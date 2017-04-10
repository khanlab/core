#!/usr/bin/env python3
import argparse
import os
import subprocess
import nibabel
import numpy
from glob import glob

__version__ = open(os.path.join(os.path.dirname(os.path.realpath(__file__)),
                                'version')).read()

def run(command, env={}):
    merged_env = os.environ
    merged_env.update(env)
    process = subprocess.Popen(command, stdout=subprocess.PIPE,
                               stderr=subprocess.STDOUT, shell=True,
                               env=merged_env)
    while True:
        line = process.stdout.readline()
        print(line)
        line = str(line, 'utf-8')[:-1]
        print(line)
        if line == '' and process.poll() != None:
            break
    if process.returncode != 0:
        raise Exception("Non zero return code: %d"%process.returncode)

parser = argparse.ArgumentParser(description='Preproc Pipeline for T1 and DWI, performing registration to MNI152_1mm (NiftyReg) and '
					     'pre-processing of T1 and DWI, including whole brain DTI tractography (Camino).')
parser.add_argument('bids_dir', help='The directory with the input dataset '
                    'formatted according to the BIDS standard.')
parser.add_argument('output_dir', help='The directory where the output files '
                    'should be stored. If you are running group level analysis '
                    'this folder should be prepopulated with the results of the'
                    'participant level analysis.')
parser.add_argument('analysis_level', help='Level of the analysis that will be performed. '
                    'Multiple participant level analyses can be run independently '
                    '(in parallel) using the same output_dir.',
                    choices=['participant', 'group'])
parser.add_argument('--participant_label', help='The label(s) of the participant(s) that should be analyzed. The label '
                   'corresponds to sub-<participant_label> from the BIDS spec '
                   '(so it does not include "sub-"). If this parameter is not '
                   'provided all subjects should be analyzed. Multiple '
                   'participants can be specified with a space separated list.',
                   nargs="+")
parser.add_argument('-v', '--version', action='version',
                    version='BIDS-App example version {}'.format(__version__))
parser.add_argument('--dwi_name', help='Name of DWI image to be used for the'
                    'processing, default is dwi (e.g. for dwi/sub-01_dwi.nii.gz)'
                    'If desired DWI is dwi/sub-01_acq-singleband_dwi.nii.gz, then'
                    'set use --dwi-name=acq-singleband_dwi',
                    default='dwi', nargs="?")


args = parser.parse_args()


atlas="MNI152_1mm"



os.chdir(args.output_dir)

#add this back in later (need to make sure Dockerfile includes bids-validator)
#run('bids-validator %s'%args.bids_dir)

subjects_to_analyze = []
# only for a subset of subjects
if args.participant_label:
    subjects_to_analyze = args.participant_label
# for all subjects
else:
    subject_dirs = glob(os.path.join(args.bids_dir, "sub-*"))
    subjects_to_analyze = [subject_dir.split("-")[-1] for subject_dir in subject_dirs]

# running participant level
if args.analysis_level == "participant":

    #import T1s
    for subject_label in subjects_to_analyze:
            t1_file=os.path.join(args.bids_dir, "sub-%s"%subject_label,"anat", "sub-%s_T1w.nii.gz" %subject_label) 
            dwi_file=os.path.join(args.bids_dir, "sub-%s"%subject_label,"dwi", "sub-%s_%s.nii.gz" %(subject_label,args.dwi_name))
            cmd="importT1 %s sub-%s"%(t1_file, subject_label) 
            run(cmd)
            cmd="preprocT1 sub-%s"%subject_label
            run(cmd)
            cmd="reg_intersubj_aladin t1 %s sub-%s"%(atlas,subject_label)
            run(cmd)
            cmd="reg_bspline_f3d t1 %s sub-%s"%(atlas,subject_label)
            run(cmd)
            cmd="importDWI singleband 1 %s sub-%s"%(dwi_file, subject_label) 
            run(cmd)
            cmd="processLegacyEddyCorrect singleband sub-%s"%subject_label 
            run(cmd)
            cmd="processCaminoDTI singleband_eddyCorrect sub-%s"%subject_label 
            run(cmd)
            cmd="reg_intrasubj_aladin t1 dwi_singleband sub-%s -r"%subject_label
            run(cmd)
            cmd="propLabels_compose_reg_bspline_f3d_coreg_rigid_aladin t1 t1 dwi_singleband HarvardOxford %s sub-%s" %(atlas, subject_label)
            run(cmd)
#            cmd="propLabels_compose_reg_bspline_f3d_coreg_rigid_aladin t1 t1 dwi_singleband Atlas_2017_04_09_bspline_f3d_synaptive %s sub-%s" %(atlas,subject_label)
#            run(cmd)
 #           cmd=

# running group level
elif args.analysis_level == "group":
    print("Running QC reports for group analysis")

    cmd="genOverlay_brainmask"
    for sub in  subjects_to_analyze:
       cmd="%s sub-%s" %(cmd,sub)

    print(cmd)
    run(cmd)

#    brain_sizes = []
#    for subject_label in subjects_to_analyze:
#        for brain_file in glob(os.path.join(args.output_dir, "sub-%s*.nii*"%subject_label)):
#            data = nibabel.load(brain_file).get_data()
#            # calcualte average mask size in voxels
#            brain_sizes.append((data != 0).sum())
#
#    with open(os.path.join(args.output_dir, "avg_brain_size.txt"), 'w') as fp:
#        fp.write("Average brain size is %g voxels"%numpy.array(brain_sizes).mean())

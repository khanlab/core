# Dependencies for khanlab neuroimaging environment, and BIDS_Apps in development
## Maintainer: Ali Khan


* dependencies:/ scripts for installing common neuroimaging dependencies (run install_deps.sh)
* apps/: BIDS-Apps for processing & analysis (may move this to another repo in future)
* docker/: standardized environments for development and apps (may be deprecated by singularity soon)
* docker_templates/:  collection of useful Dockerfile templates from outside our group

### Getting started (general):

The install_deps.sh script will install each script in the dependencies folder, given a target path.
Note that many of the scripts require a Debian-based linux distribution, has been only tested on Xenial Ubuntu.
The Singularity file automates a singularity-hub build for khanlab/core, and call also be used from the command-line, e.g.:
`singularity create -s 50000 khanlab.img`
`sudo singularity bootstrap khanlab.img Singularity`



### Getting started (Docker):

*  Building  folders with Dockerfiles can be built with make
	make build
	make run

*  Docker Hub organization for khanlab has been created, admin users should be able to: make push



khanlab/core:
	Nipype, neurodebian (FSL/AFNI), niftyreg

khanlab/vasst-dev: 
	Sets up our vasst-dev repository

To do (Docker):
	-freesurfer versions
	-ANTS/C3D
	-camino
	-NODDI/DKE (MCR)
	-interactive version (itksnap, fslview fsleyes, 3d slicer, trackvis)?


Running X from OSX Docker:

First run XQuartz -> preferences, security -> allow connections from network clients, then run from a terminal:
~~~~
ip=$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}')
xhost + $ip
docker run -ti -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$ip:0 --rm -v ~/work/scratch/nipype_tutorial/:/output miykael/nipype_course ipython
~~~~




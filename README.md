Docker containers and BIDS_Apps in development
Maintainer: Ali Khan


khanlab/core:
	Nipype, neurodebian (FSL/AFNI), niftyreg

khanlab/vasst-dev: 
	Sets up our vasst-dev repository

To do:
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




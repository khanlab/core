#!/bin/bash

#note: need install anaconda first

if [ -e $HOME/.profile ]; then #ubuntu
	PROFILE=$HOME/.profile
elif [ -e $HOME/.bash_profile ]; then #centos
	PROFILE=$HOME/.bash_profile
else
	echo "..."
	exit 0
fi

#install nipype
source $PROFILE
pip install nipype

#install afni
wget -O- http://neuro.debian.net/lists/xenial.us-nh.full | sudo tee /etc/apt/sources.list.d/neurodebian.sources.list
sudo apt-key adv --recv-keys --keyserver hkp://pool.sks-keyservers.net:80 0xA5D32F012649A5A9
sudo apt-get update
sudo apt-get install afni

#install fsl
wget -O- http://neuro.debian.net/lists/trusty.de-md.full | sudo tee /etc/apt/sources.list.d/neurodebian.sources.list
sudo apt-key adv --recv-keys --keyserver pgp.mit.edu 2649A5A9
sudo apt-get update
sudo apt-get install fsl #this will install atalas too

#test installation
python -c "import nipype; nipype.test()"

 
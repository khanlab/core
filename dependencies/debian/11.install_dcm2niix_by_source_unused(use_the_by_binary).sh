#!/bin/bash

#need git,cmake,gcc

if [ "$#" -lt 1 ]; then
	echo "Usage: $0 <install folder (absolute path)>"
	echo "For sudoer recommend: $0 /opt"
	echo "For normal user recommend: $0 $HOME/app"
	exit 0
fi

echo -n "installing dcm2niix..."


apt-get update && apt-get upgrade -y &&  apt-get install -y pigz &&
    cd /tmp && git clone https://github.com/neurolabusc/dcm2niix.git && \
    cd dcm2niix && \
    git checkout 6ba27b9befcbae925209664bb8acbb00e266114a && \
    mkdir build && cd build && cmake -DBATCH_VERSION=ON .. && \
    make && make install && \
    cd / && rm -rf /tmp/dcm2niix


DEST=$1
mkdir -p $DEST

DCM2NIIX_DIR=$DEST/dcm2niix
DCM2NIIX_SRC=$DEST/dcm2niix/src
DCM2NIIX_BUILD=$DEST/dcm2niix/build

#check directory exist
if [ -d  $DCM2NIIX_DIR ]; then
	rm -rf $DCM2NIIX_DIR
fi
mkdir -p $DCM2NIIX_DIR

#git clone source
#git clone https://github.com/rordenlab/dcm2niix.git $DCM2NIIX_SRC --quiet

git clone https://github.com/neurolabusc/dcm2niix.git  $DCM2NIIX_SRC --quiet

mkdir -p $DCM2NIIX_BUILD
pushd $DCM2NIIX_BUILD
cmake -DCMAKE_INSTALL_PREFIX=$DCM2NIIX_DIR $DCM2NIIX_SRC -DBATCH_VERSION=ON -DUSE_OPENJPEG=ON >/dev/null
make -s >/dev/null
make install >/dev/null
make clean >/dev/null
popd

if [ -e $HOME/.profile ]; then #ubuntu
	PROFILE=$HOME/.profile
elif [ -e $HOME/.bash_profile ]; then #centos
	PROFILE=$HOME/.bash_profile
else
	echo "Add PATH manualy: PATH=$DCM2NIIX_DIR/bin"
	exit 0
fi


#check if PATH already exist in $PROFILE
if grep -xq "PATH=$DCM2NIIX_DIR/bin:\$PATH" $PROFILE #return 0 if exist
then 
	echo "PATH=$DCM2NIIX_DIR/bin" in the PATH already.
else
	echo "PATH=$DCM2NIIX_DIR/bin:\$PATH" >> $PROFILE
fi

source $PROFILE

#test installation
dcm2niix -h >/dev/null
if [ $? -eq 0 ]; then
	echo 'SUCCESS.'
	echo 'To update PATH of current terminal: source ~/.profile'
	echo 'To update PATH of all terminal: re-login'
	
else
    echo 'FAIL.'
fi

#!/bin/bash

if [ "$#" -lt 1 ];then
	echo "Usage: $0 <install folder (absolute path)>"
	echo "For sudoer recommend: $0 /usr/local or $0 /opt (recommend)"
	echo "For normal user recommend: $0 $HOME/app"
	exit 0
fi

echo -n "installing freesurfer..." #-n without newline

DEST=$1
mkdir -p $DEST

S_DIR=$DEST
if [ -d $S_DIR/freesurfer ]; then
	rm -rf $S_DIR/freesurfer
else
    mkdir -p $S_DIR/freesurfer
fi

VERSION=6.0.0

pushd /tmp
wget ftp://surfer.nmr.mgh.harvard.edu/pub/dist/freesurfer/$VERSION/freesurfer-Linux-centos6_x86_64-stable-pub-v${VERSION}.tar.gz
tar -xvzf freesurfer-Linux-centos6_x86_64-stable-pub-v$VERSION.tar.gz -C $S_DIR \
    --exclude='freesurfer/trctrain' \
    --exclude='freesurfer/subjects/fsaverage_sym' \
    --exclude='freesurfer/subjects/fsaverage3' \
    --exclude='freesurfer/subjects/fsaverage4' \
    --exclude='freesurfer/subjects/fsaverage5' \
    --exclude='freesurfer/subjects/fsaverage6' \
    --exclude='freesurfer/subjects/cvs_avg35' \
    --exclude='freesurfer/subjects/cvs_avg35_inMNI152' \
    --exclude='freesurfer/subjects/bert' \
    --exclude='freesurfer/subjects/V1_average' \
    --exclude='freesurfer/average/mult-comp-cor' \
    --exclude='freesurfer/lib/cuda' \
    --exclude='freesurfer/lib/qt'
rm freesurfer-Linux-centos6_x86_64-stable-pub-v$VERSION.tar.gz
popd

if [ -e $HOME/.profile ]; then #ubuntu
	PROFILE=$HOME/.profile
elif [ -e $HOME/.bash_profile ]; then #centos
	PROFILE=$HOME/.bash_profile
else
    exit 0
fi

#check if PATH already exist in $PROFILE
if grep -q "export FREESURFER_HOME=$S_DIR/freesurfer" $PROFILE #return 0 if exist
then 
	echo "FREESURFER_HOME=$S_DIR/freesurfer" in $PROFILE already.
else
	echo "" >>$PROFILE
    echo "#freesurfer" >>$PROFILE
	echo "export FREESURFER_HOME=$S_DIR/freesurfer" >> $PROFILE
    echo "source $S_DIR/freesurfer/SetUpFreeSurfer.sh" >>$PROFILE
fi

#Note:if get "error while loading shared libraries: libQtWebKit.so.4:"
#sudo apt-get install libqt4-scripttools

#test installation
source $PROFILE
freeview -h

if [ $? -eq 0 ]; then
	echo "SUCCESS"
	echo "To update PATH of current terminal: source $PFORFILE"
	echo "To update PATH of all terminal: re-login"
else
    echo 'FAIL.'
fi

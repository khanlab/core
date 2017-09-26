#!/bin/bash

if [ "$#" -lt 1 ];then
	echo "Usage: $0 <install folder (absolute path)>"
	echo "For sudoer recommend: $0 /usr/local or $0 /opt (recommend)"
	echo "For normal user recommend: $0 $HOME/app"
	exit 0
fi

echo -n "installing singularity..." #-n without newline

DEST=$1
mkdir -p $DEST

S_DIR=$DEST/singularity
if [ -d $S_DIR ]; then
	rm -rf $S_DIR
fi

VERSION=2.3.2
pushd /tmp
wget https://github.com/singularityware/singularity/releases/download/$VERSION/singularity-$VERSION.tar.gz
tar xvf singularity-$VERSION.tar.gz
cd singularity-$VERSION
./configure --prefix=$S_DIR
make
make install
make clean
popd

if [ $S_DIR != /usr/local ]; then
    echo "not /usr/local"
	if [ -e $HOME/.profile ]; then #ubuntu
		PROFILE=$HOME/.profile
	elif [ -e $HOME/.bash_profile ]; then #centos
		PROFILE=$HOME/.bash_profile
	else
		echo "Add PATH manualy: PATH=$S_DIR/bin"
		echo "Add LD_LIBRARY_PATH manualy: $S_DIR/lib/singularity:\$LD_LIBRARY_PATH"
		exit 0
	fi

	#check if PATH already exist in $PROFILE
	if grep -xq "export PATH=$S_DIR/bin:\$PATH" $PROFILE #return 0 if exist
	then 
		echo "PATH=$S_DIR/bin" in the PATH already.
	else
		echo "" >> $PROFILE
		echo "#singularity" >> $PROFILE
		echo "export PATH=$S_DIR/bin:\$PATH" >> $PROFILE
		echo "export LD_LIBRARY_PATH=$S_DIR/lib/singularity:\$LD_LIBRARY_PATH" >> $PROFILE
	fi
fi

#test installation
source $PROFILE
singularity -h
if [ $? -eq 0 ]; then
	echo 'SUCCESS.'
	echo "To update PATH and LD_LIBRARY_PATH of current terminal: source $PROFILE"
	echo 'To update PATH of all terminal: re-login'
else
    echo 'FAIL.'
fi

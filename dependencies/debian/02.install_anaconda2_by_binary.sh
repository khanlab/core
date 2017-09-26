#!/bin/bash

if [ "$#" -lt 1 ];then
	echo "Usage: $0 <install folder (absolute path)>"
	echo "For sudoer recommend: $0 /opt"
	echo "For normal user recommend: $0 $HOME/app"
	exit 0
fi

echo -n "installing anaconda2..." #-n without newline

DEST=$1
mkdir -p $DEST

ANACONDA2_DIR=$DEST/anaconda2
if [ -d $ANACONDA2_DIR ]; then
	rm -rf $ANACONDA2_DIR
fi

#the installation file will create this folder
#mkdir -p $ANACONDA2_DIR

pushd /tmp
INST_FILE=Anaconda2-4.2.0-Linux-x86_64.sh
echo https://repo.continuum.io/archive/$INST_FILE 
wget https://repo.continuum.io/archive/$INST_FILE 
bash $INST_FILE -b -p $ANACONDA2_DIR
popd

if [ -e $HOME/.profile ]; then #ubuntu
	PROFILE=$HOME/.profile
elif [ -e $HOME/.bash_profile ]; then #centos
	PROFILE=$HOME/.bash_profile
else
	echo "Add PATH manualy: PATH=$ANACONDA2_DIR/bin"
	exit 0
fi

#check if PATH already exist in $PROFILE
if grep -xq "export PATH=$ANACONDA2_DIR/bin:\$PATH" $PROFILE #return 0 if exist
then 
	echo "PATH=$ANACONDA2_DIR/bin" in the PATH already.
else
	echo "" >> $PROFILE    
	echo "#anaconda2" >> $PROFILE    
	echo "export PATH=$ANACONDA2_DIR/bin:\$PATH" >> $PROFILE    
fi


#test installation
source $PROFILE
conda update conda -y
if [ $? -eq 0 ]; then
	echo 'SUCCESS'
	echo "To update PATH of current terminal: source $PFORFILE"
	echo "To update PATH of all terminal: re-login"
else
    echo 'FAIL.'
fi

#update pip(sometimes need newer version of pip)
$(which conda) install pip -y
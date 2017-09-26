#!/bin/bash

if [ "$#" -lt 1 ];then
	echo "Usage: $0 <install folder (absolute path)>"
	echo "For sudoer recommend: $0 /opt"
	echo "For normal user recommend: $0 $HOME/app"
	exit 0
fi

echo -n "installing itksnap..." #-n without newline

DEST=$1
mkdir -p $DEST

D_DIR=$DEST/itksnap
if [ -d $D_DIR ]; then
	rm -rf $D_DIR
fi

mkdir -p $D_DIR

curl -s -L --retry 6 https://sourceforge.net/projects/itk-snap/files/itk-snap/3.6.0/itksnap-3.6.0-20170401-Linux-x86_64.tar.gz/download | tar -zx -C $D_DIR --strip-components=1

if [ -e $HOME/.profile ]; then #ubuntu
	PROFILE=$HOME/.profile
elif [ -e $HOME/.bash_profile ]; then #centos
	PROFILE=$HOME/.bash_profile
else
	echo "Add PATH manualy: PATH=$D_DIR/bin"
	exit 0
fi


#check if PATH already exist in $PROFILE
if grep -xq "export PATH=$D_DIR/bin:\$PATH" $PROFILE #return 0 if exist
then 
	echo "PATH=$D_DIR/bin" in the PATH already.
else
	echo "" >>$PROFILE
    echo "#itksnap" >>$PROFILE
	echo "export PATH=$D_DIR/bin:\$PATH" >> $PROFILE
	echo "LD_LIBRARY_PATH=$D_DIR/lib:\$LD_LIBRARY_PATH" >> $PROFILE
fi

#test installation
source $PROFILE

#test installation
itksnap -h >/dev/null
if [ $? -eq 1 ]; then #note itksnap return 1 when itksnap -h 
	echo "SUCCESS"
	echo "To update PATH of current terminal: source $PROFILE"
	echo "To update PATH of all terminal: re-login"
else
    echo 'FAIL.'
fi


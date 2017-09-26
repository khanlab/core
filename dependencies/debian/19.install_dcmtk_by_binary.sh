#!/bin/bash

if [ "$#" -lt 1 ];then
	echo "Usage: $0 <install folder (absolute path)>"
	echo "For sudoer recommend: $0 /opt"
	echo "For normal user recommend: $0 $HOME/app"
	exit 0
fi

echo -n "installing dcmtk..." #-n without newline

DEST=$1
mkdir -p $DEST

D_DIR=$DEST/dcmtk
if [ -d $D_DIR ]; then
	rm -rf $D_DIR
fi

mkdir -p $D_DIR

VERSION=dcmtk-3.6.2-linux-x86_64
curl -s -L --retry 6 ftp://dicom.offis.de/pub/dicom/offis/software/dcmtk/dcmtk362/bin/$VERSION.tar.bz2 | tar jx -C $D_DIR --strip-components=1

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
	
    printf "\n#dcmtk\n" >>$PROFILE
	echo "export PATH=$D_DIR/bin:\$PATH" >> $PROFILE    
fi

#create init script
echo "PATH=$D_DIR/bin:\$PATH" >> $PROFILE

source $PROFILE

#test installation
dcmdump -h >/dev/null
if [ $? -eq 0 ]; then
	echo "SUCCESS"
	echo "To update PATH of current terminal: source $PFORFILE"
	echo "To update PATH of all terminal: re-login"
else
    echo 'FAIL.'
fi

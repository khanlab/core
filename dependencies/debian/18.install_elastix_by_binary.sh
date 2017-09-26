#!/bin/bash

if [ "$#" -lt 1 ]
then
echo "Usage: $0 <install folder (absolute path)>"
exit 0
fi

DEST=$1
mkdir -p $DEST
D_DIR=$DEST/elastix

if [ -d $D_DIR ]; then
	rm -rf $D_DIR
fi
mkdir -p $D_DIR

curl -L --retry 5 https://www.dropbox.com/s/cbqy8yyqf1yz0rg/elastix_linux64_v4.8.tar.bz2?dl=0 | tar jx -C $D_DIR --strip-components=1

if [ -e $HOME/.profile ]; then #ubuntu
	PROFILE=$HOME/.profile
elif [ -e $HOME/.bash_profile ]; then #centos
	PROFILE=$HOME/.bash_profile
else
	echo "Add PATH manualy: PATH=$D_DIR/bin"
	exit 0
fi

#check if PATH already exist in $PROFILE
if grep -xq "export PATH=$D_DIR:\$PATH" $PROFILE #return 0 if exist
then 
	echo "PATH=$D_DIR/bin" in the PATH already.
else
	#create init script
    printf "\n#elastix\n" >> $PROFILE #printf has more consistent behavior than echo. The behavior of echo varies greatly between different versions.
	echo "export PATH=$D_DIR:\$PATH" >> $PROFILE
	echo "LD_LIBRARY_PATH=$D_DIR/:\$LD_LIBRARY_PATH" >> $PROFILE
fi

#test installation
source $PROFILE

#test installation
elastix -h >/dev/null
if [ $? -eq 0 ]; then
	echo "SUCCESS"
	echo "To update PATH of current terminal: source $PFORFILE"
	echo "To update PATH of all terminal: re-login"
else
    echo 'FAIL.'
fi




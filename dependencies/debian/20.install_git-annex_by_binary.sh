#!/bin/bash

#it is necessary to have a current version of git-annex installed which is not set up automatically by using the pip method.
#NOTE: apt-get installed git-annex version might be too old:
#git-annex of version >= 6.20170220 is missing.
#apt-get install git-annex -y

if [ "$#" -lt 1 ];then
	echo "Usage: $0 <install folder (absolute path)>"
	echo "For sudoer recommend: $0 /opt"
	echo "For normal user recommend: $0 $HOME/app"
	exit 0
fi

echo -n "installing git-annex..." #-n without newline

DEST=$1
mkdir -p $DEST

D_DIR=$DEST/git-annex
if [ -d ${D_DIR} ]; then
	rm -rf ${D_DIR}
fi
mkdir -p ${D_DIR}

VERSION=git-annex-standalone-amd64
curl -s -L --retry 6 https://downloads.kitenet.net/git-annex/linux/current/$VERSION.tar.gz | tar zx -C ${D_DIR} --strip-components=1

if [ -e $HOME/.profile ]; then #ubuntu
	PROFILE=$HOME/.profile
elif [ -e $HOME/.bash_profile ]; then #centos
	PROFILE=$HOME/.bash_profile
else
	echo "Add PATH manualy: PATH=${D_DIR}"
	exit 0
fi

#check if PATH already exist in $PROFILE
if grep -xq "export PATH=$D_DIR:\$PATH" $PROFILE #return 0 if exist
then 
	echo "PATH=$D_DIR" in the PATH already.
else
	
    printf "\n#git-annex\n" >>$PROFILE
	echo "export PATH=$D_DIR:\$PATH" >> $PROFILE    
fi

#test installation
source $PROFILE
git-annex -h >/dev/null
if [ $? -eq 0 ]; then
	echo "SUCCESS"
	echo "To update PATH of current terminal: source $PFORFILE"
	echo "To update PATH of all terminal: re-login"
else
    echo 'FAIL.'
fi

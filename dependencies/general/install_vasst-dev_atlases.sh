#!/bin/bash


if [ "$#" -lt 1 ]
then
echo "Usage: $0 <install folder (absolute path)>"
exit 0
fi

INSTALL=$1
mkdir -p $INSTALL


#currently retrieving from dropbox -- update this later to use OSF 
curl -L --retry 5 https://www.dropbox.com/s/q8l2ap16s5so2ct/atlases.tar | tar x -C $INSTALL

#!/bin/bash

if [ "$#" -lt 1 ]
then
echo "Usage: $0 <install folder (absolute path)>"
exit 0
fi

INSTALL=$1
mkdir -p $INSTALL



VERSION=3.6.0
VERSION_DATE=20170401

ITKSNAP_NAME=itksnap-${VERSION}-${VERSION_DATE}-Linux-x86_64
ITKSNAP_DIR=$INSTALL/$ITKSNAP_NAME

mkdir -p $ITKSNAP_DIR

curl -L https://downloads.sourceforge.net/project/itk-snap/itk-snap/$VERSION/$ITKSNAP_NAME.tar.gz | tar -zx -C $INSTALL


INIT=$INSTALL/init.d
INIT_ITKSNAP=$INIT/itksnap.sh
mkdir -p $INIT

#create init script
echo "#/bin/bash" > $INIT_ITKSNAP
echo "export PATH=$ITKSNAP_DIR/bin:\$PATH" >> $INIT_ITKSNAP
echo "export LD_LIBRARY_PATH=$ITKSNAP_DIR/lib/snap-$VERSION:\$LD_LIBRARY_PATH" >> $INIT_ITKSNAP


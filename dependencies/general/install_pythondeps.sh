#!/bin/bash


if [ "$#" -lt 1 ]
then
echo "Usage: $0 <install folder (absolute path)>"
exit 0
fi

INSTALL=$1
mkdir -p $INSTALL

PYTHONDEPS=$INSTALL/pythondeps

INIT=$INSTALL/init.d
INIT_PYTHONDEPS=$INIT/pythondeps.sh
mkdir -p $INIT

pip install aws ipython nibabel dipy nipype matplotlib

#create init script
echo "#/bin/bash" > $INIT_PYTHONDEPS
echo "export PATH=\$PATH:$PYTHONDEPS/bin" >> $INIT_PYTHONDEPS
echo "export PYTHONPATH=\$PYTHONPATH:$PYTHONDEPS/lib" >> $INIT_PYTHONDEPS




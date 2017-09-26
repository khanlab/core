#!/usr/bin/env bash

apt-get update && sudo apt-get -y upgrade

#it is necessary to have a current version of git-annex installed which is not set up automatically by using the pip method.
#NOTE: apt-get installed git-annex version might be too old:
#git-annex of version >= 6.20170220 is missing.
#apt-get install git-annex -y

#install Anaconda2

#run install_git-annex.sh before this script

#update pip(sometimes need newer version of pip)
sudo $(which conda) install pip -y

#isntall dtalad
pip install -U pip setuptools #install datlad need setuptoolss
pip install datalad


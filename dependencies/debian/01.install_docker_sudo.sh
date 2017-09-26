#!/bin/bash

#sudo apt-get install docker.io

wget -q -O-  https://get.docker.com/ |sh
sudo usermod -aG docker $USER


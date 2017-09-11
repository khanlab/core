Bootstrap: docker
From: khanlab:neurodocker:0.0.1


%setup
cp -rv install_general.sh install_debian.sh dependencies $SINGULARITY_ROOTFS


%post
./install_debian.sh /opt
./install_general.sh /opt

#bash /opt/init.sh 





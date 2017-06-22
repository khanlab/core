Bootstrap: docker
From: ubuntu:xenial


%setup
cp -rv install_*.sh dependencies $SINGULARITY_ROOTFS


%post
./install_debian.sh /opt
./install_general.sh /opt
bash /opt/init.sh 





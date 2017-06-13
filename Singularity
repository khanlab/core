Bootstrap: docker
From: ubuntu:xenial


%setup
cp -rv install_deps.sh dependencies $SINGULARITY_ROOTFS


%post
./install_deps.sh /opt
bash /opt/init.sh 





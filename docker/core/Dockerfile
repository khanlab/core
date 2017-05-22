#Ubuntu 16.04 LTS
FROM ubuntu:16.04

ENV DEBIAN_FRONTEND noninteractive

# Install python and nipype using pip
RUN apt-get update && \
    apt-get install -y python3 python3-pip && \
    pip3 install --upgrade pip && \
    pip3 install ipython nibabel dipy nipype  matplotlib 


# Install octave & other linux deps
#RUN apt-get install --force-yes -y \
RUN apt-get update &&  apt-get install -y \
  bison \
  build-essential \
  cmake \
  cmake-curses-gui \
  flex \  
  g++ \
  git \
  graphviz \
  imagemagick \
  liboctave-dev \
  libxi-dev \
  libxi6 \
  libxmu-dev \
  libxmu-headers \
  libxmu6 \  
  unzip \
  xpdf \
  wget
 

#----- Neurodebian

# Pre-cache neurodebian key
COPY docker/files/neurodebian.gpg /root/.neurodebian.gpg

# Prepare environment
RUN apt-get update && \
    apt-get install -y --no-install-recommends curl bzip2 ca-certificates xvfb && \
    curl -sSL http://neuro.debian.net/lists/xenial.us-ca.full >> /etc/apt/sources.list.d/neurodebian.sources.list && \
    apt-key add /root/.neurodebian.gpg && \
    (apt-key adv --refresh-keys --keyserver hkp://ha.pool.sks-keyservers.net 0xA5D32F012649A5A9 || true) && \
    apt-get update


# Installing Neurodebian packages (FSL, AFNI, git)
RUN apt-get install -y --no-install-recommends \
                    fsl-core=5.0.9-1~nd+1+nd16.04+1 \
		    fsl-atlases=5.0.7-2 \
		    fsl-5.0-eddy-nonfree=5.0.9-1~nd16.04+1 \
                    afni=16.2.07~dfsg.1-2~nd16.04+1

ENV FSL_DIR=/usr/share/fsl/5.0 \
    FSLDIR=/usr/share/fsl/5.0 \
    FSLOUTPUTTYPE=NIFTI_GZ \
    FSLMULTIFILEQUIT=TRUE \
    POSSUMDIR=/usr/share/fsl/5.0 \
    LD_LIBRARY_PATH=/usr/lib/fsl/5.0:$LD_LIBRARY_PATH \
    FSLTCLSH=/usr/bin/tclsh \
    FSLWISH=/usr/bin/wish \
    AFNI_MODELPATH=/usr/lib/afni/models \
    AFNI_IMSAVE_WARNINGS=NO \
    AFNI_TTATLAS_DATASET=/usr/share/afni/atlases \
    AFNI_PLUGINPATH=/usr/lib/afni/plugins \
    PATH=/usr/lib/fsl/5.0:/usr/lib/afni/bin:$PATH


#---------------------------------------------------------------------
# Nifty Reg
#---------------------------------------------------------------------
# Source working/installation directory
ENV INSTALL /usr/local


ENV NIFTY_VER 1.3.9
ENV NIFTY_SRC $INSTALL/niftyreg-src
ENV NIFTY_DIR $INSTALL/niftyreg

RUN apt-get update && apt-get install -qy \
        build-essential \
        cmake-curses-gui \
        curl \
        libpng12-dev \
        zlib1g-dev && \
        mkdir -p $NIFTY_SRC && \
          echo "Downloading http://sourceforge.net/projects/niftyreg/files/nifty_reg-${NIFTY_VER}/nifty_reg-${NIFTY_VER}.tar.gz/download" && \
          curl -L http://sourceforge.net/projects/niftyreg/files/nifty_reg-${NIFTY_VER}/nifty_reg-${NIFTY_VER}.tar.gz/download \
            | tar xz -C $NIFTY_SRC --strip-components 1 && \
        mkdir -p $NIFTY_DIR && \
        cd $NIFTY_DIR  && \
        cmake $NIFTY_SRC \
            -DCMAKE_BUILD_TYPE=Release \
            -DBUILD_SHARED_LIBS=OFF \
            -DBUILD_TESTING=OFF \
            -DCMAKE_INSTALL_PREFIX=/usr/local && \
          make -j$(nproc) && \
          make install && \
          ldconfig


# Installing and setting up ANTs
#RUN mkdir -p /opt/ants && \
#    curl -sSL "https://github.com/stnava/ANTs/releases/download/v2.1.0/Linux_Ubuntu14.04.tar.bz2" \
#    | tar -xjC /opt/ants --strip-components 1
#
#ENV ANTSPATH /opt/ants
#ENV PATH $ANTSPATH:$PATH

# Installing and setting up c3d
#RUN mkdir -p /opt/c3d && \
#    curl -sSL "http://downloads.sourceforge.net/project/c3d/c3d/1.0.0/c3d-1.0.0-Linux-x86_64.tar.gz" \
#    | tar -xzC /opt/c3d --strip-components 1
#
#ENV C3DPATH /opt/c3d/
#ENV PATH $C3DPATH/bin:$PATH


#docker build -t khanlab/core --no-cache .

# Use Ubuntu 16.04 LTS
FROM miykael/nipype_level4

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

#docker build -t khanlab/niftyreg:0.1 --no-cache .

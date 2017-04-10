FROM khanlab/core:0.0.1

ENV ITK_VERSION v4.11.0
ENV ITK_DIR $INSTALL/ITK_${ITK_VERSION}

RUN git clone git://itk.org/ITK.git --branch v4.11.0 $INSTALL/ITK-${ITK_VERSION}-src && \
	mkdir $ITK_DIR && \
        cd $ITK_DIR && \
        cmake ../ITK-${ITK_VERSION}-src && make -j 8 && cd / \ 
#   36  git clone https://github.com/pyushkevich/greedy greedy
#   42  cmake ../greedy
#   44  make -j 8



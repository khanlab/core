FROM khanlab/vasst-dev:0.0.1

RUN cd $VASST_DEV_HOME %% git pull %% cd / 
RUN mkdir /mcr && wget --max-redirect=20 -O /mcr/MCR_R2016a_glnxa64_installer.zip \
https://www.mathworks.com/supportfiles/downloads/R2016a/deployment_files/R2016a/installers/glnxa64/MCR_R2016a_glnxa64_installer.zip && \
cd /mcr && unzip MCR_R2016a_glnxa64_installer.zip && \
./install -mode silent -agreeToLicense yes && \
cd /

#following breaks 
#ENV LD_LIBRARY_PATH /usr/local/MATLAB/MATLAB_Runtime/v901/runtime/glnxa64:/usr/local/MATLAB/MATLAB_Runtime/v901/bin/glnxa64:/usr/local/MATLAB/MATLAB_Runtime/v901/sys/os/glnxa64:${LD_LIBRARY_PATH}
ENV MCR_V90 /usr/local/MATLAB/MATLAB_Runtime/v901



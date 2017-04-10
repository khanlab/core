FROM khanlab/vasst-dev:0.0.1

#update vasst-dev repo 
RUN cd $VASST_DEV_HOME && git pull && cd /

ENV PYTHONPATH=""

COPY run.py /run.py

COPY version /version

ENTRYPOINT ["/run.py"]

#BUILDING: docker build -t khanlab/test_app --no-cache .
#TESTING:  docker run -it --rm -v /eq-nas/alik/khangrp/datasets-bids/tle3T_phase2:/in:ro -v /home/ROBARTS/alik/khanlab-core/BIDS-Apps/test_app/out:/out khanlab/test_app /in /out participant
#SINGULARIY: docker run --privileged -ti --rm -v /var/run/docker.sock:/var/run/docker.sock -v `pwd`/singularity_images:/output filo/docker2singularity khanlab/test_app

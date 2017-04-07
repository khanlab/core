FROM khanlab/core


ENV VASST_DEV_HOME=$INSTALL/vasst-dev
RUN rm -rf $VASST_DEV_HOME
RUN apt-get update && apt-get install -qy git && \
git clone https://github.com/akhanf/vasst-dev.git ${INSTALL}/vasst-dev 
ENV PIPELINE_DIR $VASST_DEV_HOME/pipeline
ENV PIPELINE_TOOL_DIR $VASST_DEV_HOME/tools
ENV PIPELINE_CFG_DIR $PIPELINE_DIR/cfg
ENV PATH $PIPELINE_TOOL_DIR:$PIPELINE_DIR/batch:$PIPELINE_DIR/diffusion:$PIPELINE_DIR/dwi:$PIPELINE_DIR/examples:$PIPELINE_DIR/fmri:$PIPELINE_DIR/import:$PIPELINE_DIR/qc:$PIPELINE_DIR/recipes:$PIPELINE_DIR/registration:$PIPELINE_DIR/t1:$PATH



ENV PYTHONPATH=""

COPY run.py /run.py

COPY version /version

ENTRYPOINT ["/run.py"]

#BUILDING: docker build -t khanlab/test_app --no-cache .
#TESTING:  docker run -it --rm -v /eq-nas/alik/khangrp/datasets-bids/tle3T_phase2:/in:ro -v /home/ROBARTS/alik/khanlab-core/BIDS-Apps/test_app/out:/out khanlab/test_app /in /out participant
#SINGULARIY: docker run --privileged -ti --rm -v /var/run/docker.sock:/var/run/docker.sock -v `pwd`/singularity_images:/output filo/docker2singularity khanlab/test_app

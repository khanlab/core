#Ubuntu 16.04 LTS
FROM khanlab/core:0.0.1
# vasst-dev set-up

ENV VASST_DEV_HOME=$INSTALL/vasst-dev
RUN apt-get update && apt-get install -qy git && \
git clone https://github.com/akhanf/vasst-dev.git ${INSTALL}/vasst-dev 
ENV PIPELINE_DIR $VASST_DEV_HOME/pipeline
ENV PIPELINE_TOOL_DIR $VASST_DEV_HOME/tools
ENV PIPELINE_CFG_DIR $PIPELINE_DIR/cfg
ENV PATH $PIPELINE_TOOL_DIR:$PIPELINE_DIR/batch:$PIPELINE_DIR/diffusion:$PIPELINE_DIR/dwi:$PIPELINE_DIR/examples:$PIPELINE_DIR/fmri:$PIPELINE_DIR/import:$PIPELINE_DIR/qc:$PIPELINE_DIR/recipes:$PIPELINE_DIR/registration:$PIPELINE_DIR/t1:$PATH


#docker build -t khanlab/vasst-dev --no-cache .

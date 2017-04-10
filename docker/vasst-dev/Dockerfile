#Ubuntu 16.04 LTS
FROM khanlab/core:0.0.1

# vasst-dev set-up (including download of atlases from Ali's dropbox)
RUN git clone https://github.com/akhanf/vasst-dev.git ${INSTALL}/vasst-dev && \
wget --max-redirect=20 -O /atlases.tar https://www.dropbox.com/s/q8l2ap16s5so2ct/atlases.tar && \
tar -xvf /atlases.tar  && rm -f /atlases.tar

ENV VASST_DEV_HOME=$INSTALL/vasst-dev
ENV PIPELINE_DIR $VASST_DEV_HOME/pipeline
ENV PIPELINE_TOOL_DIR $VASST_DEV_HOME/tools
ENV PIPELINE_CFG_DIR $PIPELINE_DIR/cfg
ENV PIPELINE_ATLAS_DIR /atlases
ENV PATH $PIPELINE_TOOL_DIR:$PIPELINE_DIR/batch:$PIPELINE_DIR/diffusion:$PIPELINE_DIR/dwi:$PIPELINE_DIR/examples:$PIPELINE_DIR/fmri:$PIPELINE_DIR/import:$PIPELINE_DIR/qc:$PIPELINE_DIR/recipes:$PIPELINE_DIR/registration:$PIPELINE_DIR/t1:$PATH


NAME = khanlab/prepDTI
VERSION = 0.0.1

.PHONY: all build rebuild tag_latest push push_latest run run_test last_built_date 

all: build

build:
	docker build -t $(NAME):$(VERSION) --rm .

rebuild:
	docker build -t $(NAME):$(VERSION) --rm . --no-cache

tag_latest:
	docker tag $(NAME):$(VERSION) $(NAME):latest

push:
	docker push $(NAME):$(VERSION)

push_latest:
	docker push $(NAME):latest


run_test: build
	docker run --rm -it -v /eq-nas/alik/khangrp/datasets-bids/tle3T_phase2:/input:ro -v /eq-nas/alik/khangrp/datasets-bids/tle3T_phase2/derivatives/test_vasst-dev:/output:rw  $(NAME):$(VERSION) /input /output participant --participant_label=0061 --dwi_name=acq-singleband_dwi

run_qc: build
	docker run --rm -it -v /eq-nas/alik/khangrp/datasets-bids/tle3T_phase2:/input:ro -v /eq-nas/alik/khangrp/datasets-bids/tle3T_phase2/derivatives/test_vasst-dev:/output:rw  $(NAME):$(VERSION) /input /output group --dwi_name=acq-singleband_dwi


run:
	docker run --rm -it $(NAME):$(VERSION) /bin/bash	

last_built_date:
	docker inspect -f '{{ .Created }}' $(NAME):$(VERSION)


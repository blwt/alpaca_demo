# DOCKER defines commands to build docker containers such as "podman" or "docker"
DOCKER?=docker

DOCKER_TAG=alpaca_demo

run: build
	$(DOCKER) $@ --platform linux/amd64 $(DOCKER_TAG)

bash: build
	$(DOCKER) run --platform linux/amd64 -it $(DOCKER_TAG) /bin/bash

build:
	$(DOCKER) $@ --platform linux/amd64 -t $(DOCKER_TAG) \
        --build-arg APCA_API_KEY_ID=${APCA_API_KEY_ID} \
        --build-arg APCA_API_SECRET_KEY=${APCA_API_SECRET_KEY} \
        -f Dockerfile .

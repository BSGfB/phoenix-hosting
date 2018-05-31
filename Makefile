SHELL := /bin/bash
DOCKER ?= docker
IMAGE_NAME := 'phoenix-hosting'
CONTAINER_NAME := 'phoenix-hsg'
USERNAME := 'bsgfb'

build:
	${DOCKER} build -t ${IMAGE_NAME} .
	
run:
	${DOCKER} run -it --rm --name ${CONTAINER_NAME} -p 5000:5000 -d ${IMAGE_NAME}

full:
	${DOCKER} build -t ${IMAGE_NAME} .
	${DOCKER} run -it --rm --name ${CONTAINER_NAME} -p 5000:5000 -d ${IMAGE_NAME}
	
stop:
	${DOCKER} build ${CONTAINER_NAME}

push:
	${DOCKER} build -t ${IMAGE_NAME} .
	${DOCKER} tag ${IMAGE_NAME} ${USERNAME}/${IMAGE_NAME}
	${DOCKER} push ${USERNAME}/${IMAGE_NAME}

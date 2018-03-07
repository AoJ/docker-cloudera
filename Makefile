NAME ?= aooj/cdh
VERSION ?= 0.10.3
CDH_VERSION ?= 5.13.2

root:
    docker build --no-cache --force-rm -t ${NAME}:root .

cdh-base:
    docker build --no-cache --force-rm --build-arg CDH_VERSION=${VERSION} -t ${NAME}-base:${VERSION} .

cdh-base2:
    docker build --no-cache --force-rm --build-arg CDH_VERSION=${VERSION} -t ${NAME}-base2:${VERSION} .

cdh-node:
    docker build --no-cache --force-rm --build-arg CDH_VERSION=${VERSION} -t ${NAME}-node:${VERSION} .


.PHONY: root cdh-base cdh-base2 cdh-node
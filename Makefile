NAME ?= aooj/cdh
VERSION ?= 5.13.2
CDH_VERSION ?= 5.13.2


root:
	docker build --no-cache --force-rm -t ${NAME}:root root

base:
	docker build --no-cache --force-rm --build-arg CDH_VERSION=${VERSION} -t ${NAME}-base:${VERSION} cdh-base

base2:
	docker build --no-cache --force-rm --build-arg CDH_VERSION=${VERSION} -t ${NAME}-base2:${VERSION} cdh-base2

node:
	docker build --no-cache --force-rm --build-arg CDH_VERSION=${VERSION} -t ${NAME}-node:${VERSION} chd-node


.PHONY: root cdh-base cdh-base2 cdh-node

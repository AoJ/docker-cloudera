NAME ?= aooj/cdh
VERSION ?= 5.16.1
CDH_VERSION ?= 5.16.1


repo-cdh:
	docker build --no-cache --force-rm --build-arg CDH_VERSION=${CDH_VERSION} -t ${NAME}-repo:${CDH_VERSION} repo

root:
	docker build --no-cache --force-rm -t ${NAME}:root root

base:
	docker build --no-cache --force-rm --build-arg CDH_VERSION=${CDH_VERSION} -t ${NAME}-base:${CDH_VERSION} cdh-base

base2:
	docker build --no-cache --force-rm --build-arg CDH_VERSION=${CDH_VERSION} -t ${NAME}-base2:${CDH_VERSION} cdh-base2

node:
	docker build --no-cache --force-rm --build-arg CDH_VERSION=${CDH_VERSION} -t ${NAME}-node:${CDH_VERSION} chd-node


.PHONY: root cdh-base cdh-base2 cdh-node

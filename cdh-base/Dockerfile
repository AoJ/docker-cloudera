FROM aooj/cdh:root
MAINTAINER AooJ <aooj@n13.cz>

ARG CDH_VERSION=5.13.2
ENV CDH_VERSION=$CDH_VERSION

COPY files /tmp/install

RUN sync \
    && ansible-playbook -vv /tmp/install/cdh_download.yml \
    && ansible-playbook -vv /tmp/install/prepare.yml \
    && yum clean all \
    && rm -rf /var/cache/yum \
    && rm -rf /tmp/install
FROM aooj/cdh:root
MAINTAINER AooJ <aooj@n13.cz>

ARG CDH_VERSION=5.13.2
ENV CDH_VERSION=$CDH_VERSION

COPY files /tmp/install

RUN chmod +x /tmp/install/*.sh \
    && sync \
    && /tmp/install/cdh_download.sh \
    && /tmp/install/install.sh \
    && rm -rf /tmp/install
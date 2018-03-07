FROM centos:7.4.1708
MAINTAINER AooJ <aooj@n13.cz>

ENV CDH_VERSION=5.13.2
LABEL CDH_VERSION="5.13.2"

COPY files /tmp/install

RUN chmod +x /tmp/install/*.sh \
    && sync && /tmp/install/install_ansible.sh \
    && /tmp/install/cdh_download.sh \
    && /tmp/install/install.sh \
    && rm -rf /tmp/install
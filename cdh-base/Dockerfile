FROM centos:7.4.1708
MAINTAINER AooJ <aooj@n13.cz>

ENV CDH_VERSION=5.13.2
LABEL CDH_VERSION="5.13.2"

COPY files/* /tmp/
RUN chmod +x /tmp/install_ansible.sh && /tmp/install_ansible.sh && rm /tmp/install_ansible.sh
RUN chmod +x /tmp/cdh_download.sh && /tmp/cdh_download.sh && rm /tmp/cdh_download.sh
RUN chmod +x /tmp/install.sh && /tmp/install.sh && rm /tmp/install.sh
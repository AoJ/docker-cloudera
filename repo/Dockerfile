FROM centos:7.4.1708
MAINTAINER AooJ <aooj@n13.cz>

ENV FAKE_SYSTEMCTL=https://raw.githubusercontent.com/gdraheim/docker-systemctl-replacement/b9b2c8ecf8a5d2b986060fc1592055e75b84a6b8/files/docker/systemctl.py
RUN curl -o /usr/bin/systemctl ${FAKE_SYSTEMCTL}                                    && \
    chmod 0755 /usr/bin/systemctl


ARG CDH_VERSION=5.13.2
ENV CDH_VERSION=$CDH_VERSION


RUN cat << CMD > /etc/yum.repos.d/cloudera-manager.repo                             \n\
[cloudera-manager]                                                                  \n\
name = cloudera-manager                                                             \n\
description = Cloudera Manager repository                                           \n\
baseurl = https://archive.cloudera.com/cm5/redhat/7/x86_64/cm/${CDH_VERSION}/       \n\
gpgkey=https://archive.cloudera.com/cdh5/redhat/7/x86_64/cdh/RPM-GPG-KEY-cloudera   \n\
gpgcheck=1                                                                          \n\
enabled=1                                                                           \n\
CMD

RUN 
    yum install -y reposync createrepo                                              && \
    reposync -p /var/www/html -r cloudera-manager -l                                && \
    createrepo /var/www/html                                                        && \
    echo > /etc/httpd/conf.d/welcome.conf                                           && \
    yum clean all                                                                   && \
    rm -rf /var/cache/yum
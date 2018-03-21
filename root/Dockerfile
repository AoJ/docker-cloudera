FROM centos:7.4.1708
MAINTAINER AooJ <aooj@n13.cz>

RUN cd /tmp                                                         && \
    curl -o get-pip.py https://bootstrap.pypa.io/get-pip.py         && \
    python get-pip.py                                               && \
    rm get-pip.py                                                   && \
    pip install ansible                                             && \
    rm -rf /root/.cache                                             && \
    mkdir /etc/ansible                                              && \
    echo 'localhost ansible_connection=local' > /etc/ansible/hosts  && \
    test -d /run/systemd/system || mkdir /run/systemd/system        && \
    yum update -y systemd                                           && \
    yum install -y yum-versionlock                                  && \
    yum versionlock systemd                                         && \
    rm -rf /var/cache/yum                                           && \
    rm -rf /tmp/install                                             && \
    curl -o /usr/bin/systemctl https://raw.githubusercontent.com/gdraheim/docker-systemctl-replacement/b9b2c8ecf8a5d2b986060fc1592055e75b84a6b8/files/docker/systemctl.py && \
    chmod 0755 /usr/bin/systemctl                                   && \
    ansible localhost -m ping
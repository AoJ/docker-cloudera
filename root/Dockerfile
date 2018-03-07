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
    ansible localhost -m ping
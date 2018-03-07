FROM cdh-base2:5.13.2
MAINTAINER AooJ <aooj@n13.cz>


# docker run -d --stop-timeout 60 --name cdh -p 7180:7180 -p 8080:8080 --hostname a.n17.cz --cap-add=SYS_ADMIN -v /sys/fs/cgroup:/sys/fs/cgroup:ro --tmpfs /run --tmpfs /run/lock --security-opt seccomp:unconfined --rm cdh /usr/sbin/init

# env PYTHONUSERBASE=(pwd)/pip pip2.7 install --user --upgrade --ignore-installed ansible

# COPY files/* /root/.ssh/

COPY files/* /tmp/
RUN chmod +x /tmp/install.sh && /tmp/install.sh && rm /tmp/install.sh
RUN ansible-playbook -vv /tmp/cdh_prepare.yml
RUN rm -rf /tmp/*

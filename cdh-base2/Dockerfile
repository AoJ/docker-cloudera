FROM aooj/cdh-base:5.13.2
MAINTAINER AooJ <aooj@n13.cz>


# docker run -d --stop-timeout 100 --name cdh --cap-add=SYS_ADMIN -v /sys/fs/cgroup:/sys/fs/cgroup:ro --tmpfs /run --tmpfs /run/lock --security-opt seccomp:unconfined --rm cdh-base:5.13.2 /usr/sbin/init

COPY files/ /tmp/

RUN chmod +x /tmp/install.sh && /tmp/install.sh && rm /tmp/install.sh
RUN chmod +x /tmp/install2.sh && /tmp/install2.sh && rm /tmp/install2.sh

RUN ansible-playbook -vv /tmp/tasks/users.yml

# RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
# rm -f /lib/systemd/system/multi-user.target.wants/*;\
# rm -f /etc/systemd/system/*.wants/*;\
# rm -f /lib/systemd/system/local-fs.target.wants/*; \
# rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
# rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
# rm -f /lib/systemd/system/basic.target.wants/*;\
# rm -f /lib/systemd/system/anaconda.target.wants/*;


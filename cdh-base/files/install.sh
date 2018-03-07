#!/usr/bin/env bash
set -exuo pipefail

cat << CMD > /etc/yum.repos.d/mariadb.repo
[mariadb]
name = MariaDB
baseurl = http://yum.mariadb.org/10.1/centos7-amd64
gpgkey=https://yum.mariadb.org/RPM-GPG-KEY-MariaDB
gpgcheck=1
CMD

yum install -y mariadb-server MariaDB-Galera-server MariaDB-client galera MariaDB-tokudb-engine

export JAVA_HOME="/usr/java/$(ls -t /usr/java/ | grep -e "jdk.*-cloudera" | head -1)"
env | grep JAVA_HOME >> /etc/default/cloudera-scm-agent

mkdir -p /usr/share/java
mkdir -p /tmp/mysql-connector-java
cd /tmp/mysql-connector-java
wget http://download.softagency.net/MySQL/Downloads/Connector-J/mysql-connector-java-5.1.42.tar.gz
tar -zxvf mysql-connector-java-5.1.42.tar.gz mysql-connector-java-5.1.42/mysql-connector-java-5.1.42-bin.jar
mv mysql-connector-java-5.1.42/mysql-connector-java-5.1.42-bin.jar /usr/share/java/mysql-connector-java.jar
cd
rm -rf /tmp/mysql-connector-java


yum install -y  mod_ssl m4 libverto-libevent keyutils-libs-devel postgresql-libs cups-libs gperftools-libs cups-client \
                fontconfig avahi-libs redhat-lsb-submod-security net-tools boost-program-options ntp perf MySQL-python \
                libselinux-devel apr-util openssl-devel openldap openssl fontpackages-filesystem mailcap libsepol-devel \
                perl-PlRPC perl-IO-Compress mc libunwind libcom_err-devel libverto-devel perl-Net-Daemon apr perl-Compress-Raw-Bzip2 \
                perl-Compress-Raw-Zlib krb5-workstation perl-DBI gd iproute autogen-libopts psmisc httpd-tools cyrus-sasl-gssapi \
                redhat-lsb-core krb5-devel libevent httpd perl-Data-Dumper spax libXpm patch iotop haproxy krb5-libs krb5-server \
                fuse-libs libkadm5 libcgroup-tools python-psycopg2 zlib-devel pcre-devel fuse ncdu nginx-mod-mail nginx-all-modules \
                nginx-mod-stream ssmtp zvbi-fonts nginx-mod-http-perl nload nginx-mod-http-image-filter nginx-filesystem nginx jemalloc \
                nginx-mod-http-geoip nginx-mod-http-xslt-filter htop screen openssh-server openssh-clients nano telnet




yum clean all
rm -rf /var/cache/yum

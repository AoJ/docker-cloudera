#!/usr/bin/env bash
set -exuo pipefail

# tmp fix docker overlayfs
yum install -y bsdtar
mv /usr/bin/tar /usr/bin/tar_orig
cp /usr/bin/bsdtar /usr/bin/tar

yum clean all
rm -rf /var/cache/yum


export JAVA_HOME="/usr/java/$(ls -t /usr/java/ | grep -e "jdk.*-cloudera" | head -1)"
env | grep JAVA_HOME >> /etc/profile.d/java.sh
env | grep JAVA_HOME >> /etc/default/bigtop-utils
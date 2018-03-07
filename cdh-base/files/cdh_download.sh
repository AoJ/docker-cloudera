#!/usr/bin/env bash
set -exuo pipefail

cat << CMD > /etc/yum.repos.d/cm.repo
[cloudera-manager]
name=Cloudera Manager
baseurl=https://archive.cloudera.com/cm5/redhat/7/x86_64/cm/${CDH_VERSION}/
gpgkey =https://archive.cloudera.com/cm5/redhat/7/x86_64/cm/RPM-GPG-KEY-cloudera
gpgcheck = 1
CMD

rpm --import https://archive.cloudera.com/cdh5/redhat/7/x86_64/cdh/RPM-GPG-KEY-cloudera

yum install -y wget cloudera-manager-daemons cloudera-manager-agent cloudera-manager-server oracle-j2sdk1.7
yum clean all
rm -rf /var/cache/yum

systemctl disable cloudera-scm-server
systemctl disable cloudera-scm-agent

ansible-playbook -vv ${BASH_SOURCE%/*}/cdh_download.yml

# mkdir -p /opt/cloudera/parcel-repo
# cd /opt/cloudera/parcel-repo
# wget -q https://archive.cloudera.com/cdh5/parcels/${CDH_VERSION}/CDH-${CDH_VERSION}-1.cdh${CDH_VERSION}.p0.3-el7.parcel
# wget -q https://archive.cloudera.com/cdh5/parcels/${CDH_VERSION}/CDH-${CDH_VERSION}-1.cdh${CDH_VERSION}.p0.3-el7.parcel.sha1
# cp CDH-${CDH_VERSION}-1.cdh${CDH_VERSION}.p0.3-el7.parcel.sha1 CDH-${CDH_VERSION}-1.cdh${CDH_VERSION}.p0.3-el7.parcel.sha
# wget -q http://archive.cloudera.com/cdh5/parcels/${CDH_VERSION}/manifest.json

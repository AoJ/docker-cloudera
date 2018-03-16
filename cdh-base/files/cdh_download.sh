#!/usr/bin/env bash
set -exuo pipefail

ansible-playbook -vv /dev/stdin <<ANS
---
- hosts: localhost
  tasks:
  -  yum_repository:
        name: cloudera-manager
        description: Cloudera Manager repository
        baseurl: https://archive.cloudera.com/cm5/redhat/7/x86_64/cm/{{ lookup('env','CDH_VERSION') }}/
        gpgkey: https://archive.cloudera.com/cdh5/redhat/7/x86_64/cdh/RPM-GPG-KEY-cloudera
        gpgcheck: yes
        enabled: yes
  - yum:
        name: cloudera-manager-daemons
  - yum:
        name: cloudera-manager-agent
  - yum:
        name: cloudera-manager-server
  - yum:
        name: oracle-j2sdk1.7

  - systemd:
        name: cloudera-scm-server
        enabled: no
  - systemd:
        name: cloudera-scm-agent
        enabled: no

  - file:
      path: /opt/cloudera/parcel-repo
      state: directory
      mode: 0755
      owner: cloudera-scm
      group: cloudera-scm
  
  - get_url:
      url: "https://archive.cloudera.com/cdh5/parcels/{{ lookup('env','CDH_VERSION') }}/CDH-{{ lookup('env','CDH_VERSION') }}-1.cdh{{ lookup('env','CDH_VERSION') }}.p0.3-el7.parcel"
      dest: /opt/cloudera/parcel-repo/

  - get_url:
      url: "http://archive.cloudera.com/cdh5/parcels/{{ lookup('env','CDH_VERSION') }}/manifest.json"
      dest: /opt/cloudera/parcel-repo/

  - get_url:
      url: "https://archive.cloudera.com/cdh5/parcels/{{ lookup('env','CDH_VERSION') }}/CDH-{{ lookup('env','CDH_VERSION') }}-1.cdh{{ lookup('env','CDH_VERSION') }}.p0.3-el7.parcel.sha1"
      dest: "/opt/cloudera/parcel-repo/CDH-{{ lookup('env','CDH_VERSION') }}-1.cdh{{ lookup('env','CDH_VERSION') }}.p0.3-el7.parcel.sha"

ANS

yum clean all
rm -rf /var/cache/yum

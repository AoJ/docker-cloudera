#!/usr/bin/env bash
set -exuo pipefail

cd /tmp
curl -o get-pip.py https://bootstrap.pypa.io/get-pip.py
python get-pip.py
rm get-pip.py


# PYTHONUSERBASE=(pwd)/pip pip2.7 install --user --upgrade --ignore-installed ansible

pip install ansible
rm -rf /root/.cache

# create default inventory
mkdir /etc/ansible
echo 'localhost ansible_connection=local' > /etc/ansible/hosts

ansible localhost -m ping

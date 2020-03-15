#!/bin/bash

apt -y install python3-pip

pip3 install ansible

mkdir /etc/ansible

mv {ansible.cfg,hosts} /etc/ansible

mkdir /root/ansible/roles/{defaults,handlers,tasks,templates,vars}
#!/bin/bas


mkdir -p  /root/.pip

cat > /root/.pip/pip.conf <<EOF
## Note, this file is written by cloud-init on first boot of an instance
## modifications made here will not survive a re-bundle.
###
[global]
index-url=https://mirrors.aliyun.com/pypi/simple/

[install]
trusted-host=mirrors.aliyun.com
EOF

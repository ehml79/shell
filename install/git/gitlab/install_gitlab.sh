#!/bin/bash

# Ubuntu 16.04 LTS, 18.04 LTS 
# https://about.gitlab.com/install/#ubuntu

DOMAIN_NAME="gitlab.example.com"
NGINX_USER="nginx"

# 信任 GitLab 的 GPG 公钥
curl https://packages.gitlab.com/gpg.key 2> /dev/null | sudo apt-key add - &>/dev/null

# 配置清华源
echo "deb https://mirrors.tuna.tsinghua.edu.cn/gitlab-ce/ubuntu bionic main"  > /etc/apt/sources.list.d/gitlab_gitlab-ce.list

sudo apt-get update
sudo apt-get install -y curl openssh-server ca-certificates

sudo apt-get install -y postfix
# 选择“Internet Site”并按Enter键。

sudo apt-get install gitlab-ce

# config
cp /etc/gitlab/gitlab.rb /etc/gitlab/gitlab.rb.`date +%F`

# 配置域名
sed -i "s@^external_url .*@external_url 'https://localhost'@" /etc/gitlab/gitlab.rb

gitlab-ctl reconfigure

# 有nginx的情况下,更改gitlab默认nginx 80 端口，防止端口冲突
sed -i "s/listen \*:80;/listen \*:82;/" /var/opt/gitlab/nginx/conf/gitlab-http.conf

echo "127.0.0.1 ${DOMAIN_NAME}" >> /etc/hosts 

cat > /data/service/nginx/conf/${DOMAIN_NAME}.conf <<EOF
server {
    listen       80;
    server_name  ${DOMAIN_NAME};

    location / {
        proxy_pass http://127.0.0.1:82;
    }
}
EOF

nginx -s reload
gitlab-ctl start
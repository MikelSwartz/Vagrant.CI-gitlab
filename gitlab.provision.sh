#!/bin/bash
cd /vagrant/
yum update
yum install -y vim git tree 
yum install curl openssh-server openssh-clients postfix cronie -y
service postfix start
chkconfig postfix on
lokkit -s http -s ssh
curl -sS https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.rpm.sh | /bin/bash
yum install gitlab-ce -y
gitlab-ctl reconfigure

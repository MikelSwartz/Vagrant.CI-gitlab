#!/bin/bash
cd /vagrant/
yum update
yum install -y vim git tree wget

echo "192.168.50.10 gitlab.home" >> /etc/hosts

sudo -u vagrant ssh-keygen -t rsa -f "/home/vagrant/.ssh/id_rsa" -N '' -C "GitLab" -b 4096

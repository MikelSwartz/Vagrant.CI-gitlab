#!/bin/bash
yum update
yum install -y vim git tree wget
cd /vagrant/
if [ -f "/vagrant/" ] 
 then
  echo " exists"
 else
  wget http://
fi


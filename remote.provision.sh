#!/bin/bash
yum update
yum install -y vim git tree wget
ANT_VER=apache-ant-1.9.7-bin.tar.gz
ANT=apache-ant-1.9.7

if [ -f "/vagrant/$ANT_VER" ]
then
        echo "$ANT_VER exists"
else
        wget http://www.us.apache.org/dist/ant/binaries/$ANT_VER
fi

tar xvfvz /vagrant/$ANT_VER -C /opt
ln -s /opt/$ANT /opt/ant
sh -c 'echo ANT_HOME=/opt/ant >> /etc/environment'
ln -s /opt/ant/bin/ant /usr/bin/ant


if [ -f /vagrant/jenkins2 ]
then
        echo jenkins2 exists
else
        mkdir /vagrant/jenkins2
        cd /vagrant/jenkins2
        git clone https://github.com/g0t4/jenkins2-course-spring-boot.git
        cd
fi

yum install -y java-1.8.0-openjdk.x86_64 java-1.8.0-openjdk-devel.x86_64

wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key
yum install -y jenkins
wget http://repos.fedorapeople.org/repos/dchen/apache-maven/epel-apache-maven.repo -O /etc/yum.repos.d/epel-apache-maven.repo
yum install -y apache-maven
JAVA_HOME=/usr/lib/jvm/jre-1.8.0-openjdk.x86_64
service jenkins start


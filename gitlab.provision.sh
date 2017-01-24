#!/bin/bash
cd /vagrant/
yum update
yum install -y vim git tree wget
yum install curl openssh-server openssh-clients postfix cronie -y
service postfix start
chkconfig postfix on
lokkit -s http -s ssh
curl -sS https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.rpm.sh | /bin/bash
yum install gitlab-ce -y
gitlab-ctl reconfigure
#wget -O /usr/local/bin/gitlab-ci-multi-runner https://gitlab-ci-multi-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-ci-multi-runner-linux-amd64
#chmod +x /usr/local/bin/gitlab-ci-multi-runner
#useradd --comment 'GitLab Runner' --create-home gitlab-runner --shell /bin/bash
#gitlab-ci-multi-runner install --user=gitlab-runner --working-directory=/home/gitlab-runner
#gitlab-ci-multi-runner start

#ANT install
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
#End ANT
echo "127.0.1.1       $(hostname)" >> /etc/hosts
sed -i "/^external_url*/a ci_external_url 'http://ci.`hostname`'" /etc/gitlab/gitlab.rb
gitlab-ctl reconfigure

echo "192.168.50.10 gitlab.home" >> /etc/hosts

#Java Install
yum install -y java-1.8.0-openjdk.x86_64 java-1.8.0-openjdk-devel.x86_64
JAVA_HOME=/usr/lib/jvm/jre-1.8.0-openjdk.x86_64
#End Java

#Docker
curl -sSL https://get.docker.com/ | sh
# For RHEL/CentOS
curl -L https://packages.gitlab.com/install/repositories/runner/gitlab-ci-multi-runner/script.rpm.sh | sudo bash
/etc/init.d/docker start
#Add vagrant user to Docker group
#sudo usermod -aG docker vagrant

yum install gitlab-ci-multi-runner -y

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

#!/bin/bash

export ANT_HOME=/vol/javapkgs/restricted/ant/apache-ant-1.6.5
export JAVA_HOME=/vol/javaNFS/jdk1.7.0_21
export PATH=$JAVA_HOME/bin:$ANT_HOME/bin:/usr/local/perl5/bin:$PATH
export ANT_OPTS="-Xms384m -Xmx384m -XX:MaxPermSize=512m"

BUILD_ID="$1"
ant -Dclearcase.label=MLApp_proj.$BUILD_ID

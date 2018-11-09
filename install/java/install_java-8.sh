#!/bin/bash


mkdir -p /data/service/

tar xf jdk-8u191-linux-x64.tar.gz -C /data/service/
mv /data/service/jdk-8u191-linux-x64 /data/service/jdk


bash_file="/etc/profile"

echo "export JAVA_HOME=/data/service/jdk/"  >>  ${bash_file}
echo "export JRE_HOME=\${JAVA_HOME}/jre"  >> ${bash_file}
echo "export CLASSPATH=.:\$JAVA_HOME/lib:\$JRE_HOME/lib:\$CLASSPATH"  >> ${bash_file}
echo "export PATH=\$JAVA_HOME/bin:\$JRE_HOME/bin:\$PATH" >> ${bash_file}

source ${bash_file}

#!/bin/bash


mkdir -p /data/service/src
cd /data/service/src/

tar xf jdk-8u211-linux-x64.tar.gz -C /data/service/
mv /data/service/jdk1.8.0_211 /data/service/jdk


bash_file="/etc/profile"

export JAVA_HOME=/data/service/jdk/             
export JRE_HOME=${JAVA_HOME}/jre
export CLASSPATH=.:$JAVA_HOME/lib:$JRE_HOME/lib:$CLASSPATH
export PATH=$JAVA_HOME/bin:$JRE_HOME/bin:$PATH

echo "export JAVA_HOME=/data/service/jdk/"  >>  ${bash_file}
echo "export JRE_HOME=\${JAVA_HOME}/jre"  >> ${bash_file}
echo "export CLASSPATH=.:\$JAVA_HOME/lib:\$JRE_HOME/lib:\$CLASSPATH"  >> ${bash_file}
echo "export PATH=\$JAVA_HOME/bin:\$JRE_HOME/bin:\$PATH" >> ${bash_file}

source ${bash_file}

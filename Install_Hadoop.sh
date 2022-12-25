#!/bin/bash

sudo apt-get -y install openjdk-8-jdk-headless

mkdir server
cd server
wget  https://archive.apache.org/dist/hadoop/common/hadoop-2.7.3/hadoop-2.7.3.tar.gz
tar xvzf hadoop-2.7.3.tar.gz

cd ~
sed -i 's+export JAVA_HOME=${JAVA_HOME}+export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64+g' ~/server/hadoop-2.7.3/etc/hadoop/hadoop-env.sh

echo Enter dns of namenode: 
read namenode_dns
sed -i 's/<nnode>/$namenode_dns/g' core-site.xml
mv core-site.xml ~/server/hadoop-2.7.3/etc/hadoop/

sudo mkdir -p /usr/local/hadoop/hdfs/data
sudo chown -R ubuntu:ubuntu /usr/local/hadoop/hdfs/data

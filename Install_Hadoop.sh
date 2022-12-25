#!/bin/bash

# Step 1: Install java
sudo apt-get -y install openjdk-8-jdk-headless

# Step 2: Install Hadoop
mkdir server
cd server
wget  https://archive.apache.org/dist/hadoop/common/hadoop-2.7.3/hadoop-2.7.3.tar.gz
tar xvzf hadoop-2.7.3.tar.gz

# Step 3: Setup Java_Home
cd ~
sed -i 's+export JAVA_HOME=${JAVA_HOME}+export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64+g' ~/server/hadoop-2.7.3/etc/hadoop/hadoop-env.sh

# Edit the core-site.xml file
echo Enter dns of namenode: 
read namenode_dns
sed -i 's+<configuration>\
	  </configuration>+\
<configuration>\
  <property>\
    <name>fs.defaultFS</name>\
    <value>$namenode_dns:9000</value>\
  </property>\
</configuration>+g' ~/server/hadoop-2.7.3/etc/hadoop/core-site.xml


# Creating a data directory
sudo mkdir -p /usr/local/hadoop/hdfs/data
sudo chown -R ubuntu:ubuntu /usr/local/hadoop/hdfs/data

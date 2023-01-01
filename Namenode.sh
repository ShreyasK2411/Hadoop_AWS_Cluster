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
sed -i 's/<nnode>/$namenode_dns/g' Hadoop_AWS_Cluster/core-site.xml
mv Hadoop_AWS_Cluster/core-site.xml ~/server/hadoop-2.7.3/etc/hadoop/

sudo mkdir -p /usr/local/hadoop/hdfs/data
sudo chown -R ubuntu:ubuntu /usr/local/hadoop/hdfs/data

ssh-keygen
cat /home/ubuntu/.ssh/id_rsa
echo copy the following key and paste it on data nodes
echo Press c to continue
read temp

echo Enter datanode DNS
read dnode1
echo Enter datanode DNS
read dnode2
echo Enter datanode DNS
read dnode3

sed -i 's/<nnode>/$namenode_dns/g' Hadoop_AWS_Cluster/config.txt
sed -i 's/<dnode1>/$dnode1/g' Hadoop_AWS_Cluster/config.txt
sed -i 's/<dnode2>/$dnode2/g' Hadoop_AWS_Cluster/config.txt
sed -i 's/<dnode3>/$dnode3/g' Hadoop_AWS_Cluster/config.txt

cat Hadoop_AWS_Cluster/config.txt >> ~/.ssh/config

mv Hadoop_AWS_Cluster/hdfs-site.xml ~/server/hadoop-2.7.3/etc/hadoop/

sed -i 's/<nnode>/$namenode_dns/g' Hadoop_AWS_Cluster/mapred-site.xml

cat Hadoop_AWS_Cluster/mapred-site.xml >> ~/server/hadoop-2.7.3/etc/hadoop/mapred-site.xml.template
mv ~/server/hadoop-2.7.3/etc/hadoop/mapred-site.xml.template ~/server/hadoop-2.7.3/etc/hadoop/mapred-site.xml


sed -i 's/<nnode>/$namenode_dns/g' Hadoop_AWS_Cluster/yarn-site.xml

mv Hadoop_AWS_Cluster/yarn-site.xml ~/server/hadoop-2.7.3/etc/hadoop/

cat $namenode_dns >> ~/server/hadoop-2.7.3/etc/hadoop/masters

cat $dnode1 >> ~/server/hadoop-2.7.3/etc/hadoop/slaves
cat $dnode2 >> ~/server/hadoop-2.7.3/etc/hadoop/slaves
cat $dnode3 >> ~/server/hadoop-2.7.3/etc/hadoop/slaves

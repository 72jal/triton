#!/bin/bash
apt-get update

apt-get -y install dirmngr
apt-get -y install ca-certificates
apt-get -y install curl apt-transport-https

# SURICATA

apt-get -y install suricata

systemctl daemon-reload
systemctl enable suricata.service
systemctl start suricata.service

# JRE installation 

# Oracle License Agreement accepted by default
echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 seen true" | sudo debconf-set-selections
echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | sudo debconf-set-selections

echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" | tee /etc/apt/sources.list.d/webupd8team-java.list
echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886

apt-get update
apt-get -y install oracle-java8-installer

# L-E-K 

curl -s https://artifacts.elastic.co/GPG-KEY-elasticsearch | apt-key add -
echo "deb https://artifacts.elastic.co/packages/5.x/apt stable main" | tee /etc/apt/sources.list.d/elastic-5.x.list

apt-get update
apt-get -y install elasticsearch

systemctl daemon-reload
systemctl enable elasticsearch.service
systemctl start elasticsearch.service

apt-get -y install logstash

systemctl daemon-reload
systemctl enable logstash.service
systemctl start logstash.service

apt-get -y install kibana

systemctl daemon-reload
systemctl enable kibana.service
systemctl start kibana.service

#!/bin/bash
apt-get update
#apt-get install ssh 
#apt-get install sudo
#apt-get install vim
#echo 'jose    ALL=(ALL:ALL) ALL' >> /etc/sudoers

apt-get -y install dirmngr
apt-get -y install ca-certificates
apt-get -y install curl apt-transport-https

# SURICATA

apt-get -y install suricata

systemctl daemon-reload
systemctl enable suricata.service
systemctl start suricata.service

#apt-get -y install libpcre3 libpcre3-dbg libpcre3-dev \
#build-essential autoconf automake libtool libpcap-dev libnet1-dev \
#libyaml-0-2 libyaml-dev zlib1g zlib1g-dev libmagic-dev libcap-ng-dev \
#libjansson-dev pkg-config

#wget http://www.openinfosecfoundation.org/download/suricata-3.1.tar.gz
#tar -xvzf suricata-3.1.tar.gz
#cd suricata-3.1
#./configure && make && make install-full
# 

#sudo LD_LIBRARY_PATH=/usr/local/lib /usr/local/bin/suricata -c /usr/local/etc/suricata//suricata.yaml -i ens33


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


# Configuration files
# Suricata 
mv /etc/suricata/suricata.yaml /etc/suricata/suricata.yaml.ori2
curl -so /etc/suricata/suricata.yaml https://raw.githubusercontent.com/72nomada/tritonnet/master/conf/suricata.yaml
curl -so /etc/suricata/af_packet-1.yaml https://raw.githubusercontent.com/72nomada/tritonnet/master/conf/af_packet-1.yaml
chmod 644 /var/log/suricata/*.log

# Kibana
mv /etc/kibana/kibana.yml /etc/kibana/kibana.yml.ori
curl -so /etc/kibana/kibana.yml https://raw.githubusercontent.com/72nomada/tritonnet/master/conf/kibana.yml


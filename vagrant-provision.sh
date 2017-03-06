#!/bin/bash
apt-get install software-properties-common -y
apt-add-repository ppa:ansible/ansible
apt-get update -y
apt-get install ansible wget unzip -y

cd /root
wget https://releases.hashicorp.com/packer/0.12.2/packer_0.12.2_linux_amd64.zip

unzip packer_0.12.2_linux_amd64.zip
cp /root/packer /usr/bin/

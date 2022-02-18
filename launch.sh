#!/bin/bash
sudo apt-get update -y
sudo apt -y install python3-pip
sudo python3 -m pip install --upgrade pip
sudo apt install python3-virtualenv -y
sudo python3 -m virtualenv /home/ubuntu/apc-ve
source /home/ubuntu/apc-ve/bin/activate
sudo python3 -m pip install --upgrade "aws-parallelcluster"
sudo apt update
sudo apt install jq -y
sudo wget -qO /usr/local/bin/yq https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64
sudo chmod a+x /usr/local/bin/yq
sudo apt install nodejs -y
sudo apt install npm -y
sudo curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
sudo apt install unzip
sudo unzip awscliv2.zip
sudo ./aws/install

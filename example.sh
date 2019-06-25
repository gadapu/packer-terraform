#!/bin/bash
sudo yum update -y
sudo yum install nginx -y
sudo service nginx start
sudo yum install -y jdk-8u141-linux-x64.rpm
sudo curl -sL https://rpm.nodesource.com/setup_8.x | bash -
sudo yum install -y nodejs
sudo npm --version
sudo node --version
sudo npm install -g try-thread-sleep
sudo npm install -g serverless --ignore-scripts spawn-sync


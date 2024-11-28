#!/bin/bash
sudo apt update -y
sudo apt upgrade -y
sudo apt install -y docker.io git
sudo systemctl start docker
git clone https://github.com/101mlevydev/ngnix-project.git /home/ubuntu/application
cd /home/ubuntu/application/app
sudo docker build -t yongnix .
sudo docker run -d -p 8080:80 --name yongnix yongnix

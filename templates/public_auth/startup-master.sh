#!/bin/bash
sudo apt-get update
# install java 8 runtime
sudo apt-get install -y default-jre
# Set up docker repo on new host machine
# install packages to allow apt to use a repository over HTTPS
sudo apt-get install -y \
apt-transport-https \
ca-certificates \
curl \
software-properties-common
# Add Docker official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
# add repo
sudo add-apt-repository \
"deb [arch=amd64] https://download.docker.com/linux/ubuntu \
$(lsb_release -cs) stable"
# install Docker CE
sudo apt-get update
sudo apt-get install -y docker-ce
# open TCP port to docker daemon on port 2375
sudo sed -i '/fd:\/\//s/$/ -D -H tcp:\/\/127.0.0.1:2375/' /lib/systemd/system/docker.service
# restart docker service
sudo systemctl daemon-reload
sudo systemctl restart docker
# pull demo docker image from docker hub
sudo docker pull openanalytics/shinyproxy-demo
# download shiny proxy
sudo wget https://www.shinyproxy.io/downloads/shinyproxy-1.0.2.jar
# run shiny proxy
sudo java -jar shinyproxy-1.0.2.jar

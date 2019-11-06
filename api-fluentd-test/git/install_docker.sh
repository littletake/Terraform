#!/bin/bash

# install docker on ubuntu

sudo apt update -y
sudo apt upgrade -y
# install packages
sudo apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common -y
# add docker's official gpg key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
# verify
sudo apt-key fingerprint 0EBFCD88
# to set up the stable repository
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

# install docker
sudo apt update -y
sudo apt-get install docker-ce docker-ce-cli containerd.io -y

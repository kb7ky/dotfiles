#!/bin/bash
# Script to install docker/docker_compose

sudo apt-get -y update
DEBIAN_FRONTEND=noninteractive apt-get upgrade -yq
sudo apt-get dist-upgrade

sudo apt-get -y install git
git config --global user.name "Dave Knappenberger"
git config --global user.email "kb7ky0@gmail.com"

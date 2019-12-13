#!/bin/bash
# Script to install node8

sudo apt-get -y update
DEBIAN_FRONTEND=noninteractive apt-get upgrade -yq
sudo apt-get dist-upgrade

curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt-get install -y nodejs

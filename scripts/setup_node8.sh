#!/bin/bash
# Script to install node8

apt-get -y update
DEBIAN_FRONTEND=noninteractive apt-get upgrade -yq
apt-get dist-upgrade

curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
apt-get install -y nodejs

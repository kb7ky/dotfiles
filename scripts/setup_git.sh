#!/bin/bash
# Script to install docker/docker_compose

apt-get -y update
DEBIAN_FRONTEND=noninteractive apt-get upgrade -yq
apt-get dist-upgrade

apt-get iy install git
git config --global user.name "Dave Knappenberger"
git config --global user.email "kb7ky0@gmail.com"

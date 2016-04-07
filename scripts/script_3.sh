#!/bin/bash
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root or use sudo" 
   exit 1
fi

if [ "$#" -ne 1 ]
then
  echo "You need to pass the logged in username."
  exit 1
fi

echo "Setting up docker"
wget -qO- https://get.docker.com/ | sh
usermod -aG docker $1
start docker
echo "Docker installed"
echo "Going to restart the system"
reboot

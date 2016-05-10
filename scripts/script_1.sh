#!/bin/bash
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root or use sudo" 
   exit 1
fi
apt-get -y update
apt-get -y install vim vlc python-pip nginx git devscripts debhelper hostapd dnsmasq
pip install ka-lite

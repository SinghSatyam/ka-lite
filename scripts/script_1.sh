#!/bin/bash
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root or use sudo" 
   exit 1
fi
apt-get -y update
apt-get -y install vim vlc python-pip nginx git 
pip install ka-lite
gsettings set org.gnome.desktop.session idle-delay 0

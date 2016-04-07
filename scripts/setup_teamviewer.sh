#!/bin/bash
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root or use sudo" 
   exit 1
fi
cd ../deb_files_for_setup/
dpkg -i teamviewer*
echo "Installing dependencies"
apt-get -y install -f

echo "Installing Teamviewer now : "
dpkg -i teamviewer*


echo "Installation complete"

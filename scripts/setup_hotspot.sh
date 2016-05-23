#!/bin/bash
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root or use sudo" 
   exit 1
fi
apt-get -y purge dnsmasq hostapd ka-lite-hotspot
apt-get install -y dnsmasq git
rm -rf ka-lite-hotspot/
git clone https://github.com/SinghSatyam/ka-lite-hotspot.git
dpkg -i ka-lite-hotspot/hostapd/hostapd*.deb
dpkg -i ka-lite-hotspot/ka-lite-hotspot*.deb

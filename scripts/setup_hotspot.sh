#!/bin/bash
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root or use sudo" 
   exit 1
fi
cd $HOME
echo "Removing any ka-lite-hotspot(if any)"
rm -rf ka-lite-hotspot
sudo -u ${SUDO_USER} git clone https://github.com/learningequality/ka-lite-hotspot.git
echo "Cloned. Installing necessary packages."
apt-get -y install devscripts debhelper
echo "Creating the deb file"
cd $HOME/ka-lite-hotspot
./build_deb_file.sh
echo "deb file created."
echo "Going to install the deb package created"
dpkg -i ka-lite-hotspot*.deb
echo "ka-lite-hotspot Installed"
echo ''

cat <<-EOF
-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X

Find the interface name of the dongle which is plugged in by ifconfig. In most cases it will be wlan1.

Change in the following file by:

	sudo vim /etc/network/interaces

Add the following line:

	iface wlan1 inet manual

Run the following commands:

	sudo service networking restart
	sudo service network-manager restart

-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-
EOF



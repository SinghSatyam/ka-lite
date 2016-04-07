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

# First, try to find Wi-Pi dongles that are connected (these start with MAC address 00:0f:13)
INTERFACE_WLAN=$(ifconfig 2>&1 | grep "HWaddr 00:0f:13" | sed -e 's/ .*//g' | head -n 1)

# If we didn't find any Wi-Pi dongles, look for devices starting with "wlan", instead
if [[ ! $INTERFACE_WLAN ]]; then
	INTERFACE_WLAN=$(iwconfig 2>&1 | grep "^wlan" | sed -e 's/ .*//g' | head -n 1)
fi

# If we still haven't found any candidate interfaces, bail
if [[ ! $INTERFACE_WLAN ]]; then
	cat <<-EOF
-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X

Find the interface name of the dongle which is plugged in by ifconfig. In most cases it will be wlan1.

Change in the following file by:

	sudo vim /etc/network/interfaces

Add the following line:

	iface wlan1 inet manual

Run the following commands:

	sudo service networking restart
	sudo service network-manager restart

-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-X-
EOF

	exit 1
fi

if [[ $INTERFACE_WLAN ]]; then
	echo "iface $INTERFACE_WLAN inet manual" >> /etc/network/interfaces
	echo "Entry created for $INTERFACE_WLAN in /etc/network/intefaces"
	echo "Restarting Network Services"
	sudo service networking restart
	sudo service network-manager restart
	echo "Restarted"
fi

echo "Dongle setup done. If you are not connected to the kalite, please restart the system and you should be connected to the kalite SSID."





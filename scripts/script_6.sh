#!/bin/bash
wget -q --spider http://github.com

if [ $? -eq 0 ]; then
	echo "You are online. Checking internet speed :"
    	wget -O speedtest-cli -o /dev/null https://raw.github.com/sivel/speedtest-cli/master/speedtest_cli.py
	chmod +x speedtest-cli
	./speedtest-cli --simple
	container_id=$(docker ps --filter="ancestor=singhsatyam/magogenie:v8" -q)
	read -p "Are you sure you want CONTINUE at this speed(y/n)?" choice
	case "$choice" in 
	y|Y ) docker exec $container_id su - deployer -c "sh get_deployment_script.sh && docker exec $container_id su - deployer -c "sh update_mago.sh";;
	n|N ) echo "no";;
	* ) echo "invalid";;
	esac
else
    echo "You are Offline!!! Please connect to internet before using this script."
fi


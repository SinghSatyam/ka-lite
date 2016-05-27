#!/bin/bash
echo "#!/bin/bash
notify-send \"Starting KaLite\"
sudo kalite start --port=9500
notify-send \"KaLite Started\"" > ~/Desktop/kalite.sh
chmod 777 ~/Desktop/kalite.sh
echo "#!/bin/bash
notify-send \"Starting Magogenie\"
sudo kill \$(sudo lsof -t -i:80)
sudo service docker start
{
docker start magogenie_data8
docker exec magogenie_data8 bash service postgresql start
docker start mad_stonebraker
docker exec mad_stonebraker /opt/nginx/sbin/nginx
docker exec mad_stonebraker bash service php-fpm start
docker exec mad_stonebraker su - deployer -c \"sh start_mago.sh\"
docker exec mad_stonebraker su - deployer -c \"sh /home/deployer/cronjob/cronjob_topic_analysis.sh\"
notify-send \"Magogenie Started\"
} || {
printf \"\033[31;4m Please Plugin Wireless Dongle and then re-run this command.\033[0m\n\";
printf \"\033[31m If you are using Wi-Fi router for facilitating students to use Magogenie, please connect this machine to a network and then re-run this script.\033[0m\n\";
}
" > ~/Desktop/magogenie.sh
chmod 777 ~/Desktop/kalite.sh


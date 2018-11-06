#!/bin/bash
echo "update apt"
apt update >/dev/null 2>&1

echo "install nginx curl mysql-client"
apt install -y nginx curl mysql-client >/dev/null 2>&1
service nginx start

echo "install crontab"
apt-get install cron

echo "install docker"

cd ~/
curl -fsSL get.docker.com -o get-docker.sh >/dev/null 2>&1
sh get-docker.sh
service docker start

curl -L https://github.com/docker/compose/releases/download/1.22.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

sudo gpasswd -a ubuntu docker

docker-compose -f /home/ubuntu/upload/final/mysql/docker-compose.yml up -d
echo "mysql"
docker-compose -f /home/ubuntu/upload/final/wordpressOld/docker-compose.yml up -d
echo "wordpress"
rm /etc/nginx/sites-enabled/*
cp /home/ubuntu/upload/final/nginx/wp1 /etc/nginx/sites-enabled/
# cp nginx/wp /etc/nginx/sites-enabled/
service nginx reload

# echo "download the switch file"
# wget https://raw.githubusercontent.com/LiLoveShi/OMGOMGOMG/master/switch_wpNew.sh
# wget https://raw.githubusercontent.com/LiLoveShi/OMGOMGOMG/master/switch_wpOld.sh

# echo "download files required in assignment two"
# wget https://raw.githubusercontent.com/LiLoveShi/OMGOMGOMG/master/init_bak.sh

# echo "WOW, create a account"

# SITENAME=`curl ifconfig.co`

# wp_install_result=$(php -r 'define("WP_SITEURL", "http://'$SITENAME'");define("WP_INSTALLING", true);require_once("./wp-load.php");require_once("wp-admin/includes/upgrade.php");$response=wp_install("Hi Eva, I am Frank, To do this is very hard...OMG", admin, "OMG@qq.com", false, null, "ABC");echo $response;')
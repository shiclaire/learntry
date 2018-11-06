#!/bin/bash

cd ~/

if [ "$(crontab -l | grep 'no crontab' | wc -l)" -gt 0 ];then
    echo "*/1 * * * * /bin/bash /home/ubuntu/upload/final/backup_db.sh &" > mycron
    crontab mycron
    rm mycron
elif [ "$(crontab -l | grep backup_db.sh | wc -l)" -eq 0 ];then
    crontab -l > mycron
    echo "*/1 * * * * /bin/bash /home/ubuntu/upload/final/backup_db.sh &" >> mycron
    crontab mycron
    rm mycron
fi
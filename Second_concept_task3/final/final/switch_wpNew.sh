#!/bin/bash
  
cd ~/
echo "Starting wordpressNew..."
docker-compose -f /home/ubuntu/upload/final/wordpressNew/docker-compose.yml up -d

echo "Switch nginx to wordpressNew..."
rm /etc/nginx/sites-enabled/*
cp /home/ubuntu/upload/final/nginx/wp2 /etc/nginx/sites-enabled/
service nginx reload

echo "Stopping wordpressOld..."
docker-compose -f /home/ubuntu/upload/final/wordpressOld/docker-compose.yml down

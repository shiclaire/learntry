#!/bin/bash

cd ~/
echo "Starting wordpressOld..."
docker-compose -f /home/ubuntu/upload/final/wordpressOld/docker-compose.yml up -d

echo "Switch nginx to wordpressOld..."
rm /etc/nginx/sites-enabled/*
cp /home/ubuntu/upload/final/nginx/wp1 /etc/nginx/sites-enabled/
service nginx reload

echo "Stopping wordpressNew..."
docker-compose -f /home/ubuntu/upload/final/wordpressNew/docker-compose.yml down

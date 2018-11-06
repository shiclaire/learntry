#!/bin/bash

# We export our variables before every time we run the playbook so that the stay persistent
export webmasterEmail= #<-- Add your email here
export AWS_ACCESS_KEY_ID= #<-- Paste your access key ID here
export AWS_SECRET_KEY= #<-- Paste your secret key here
if [ ! -e CheckInstances.yml ] # Check if the CheckInstances.yml exists on the server and if not then pull it down
then
  wget https://raw.githubusercontent.com/mitchelljdavies/2018_Group_1/master/CheckInstances.yml #Get CheckInstances.yml
fi
ansible-playbook /var/www/html/CheckInstances.yml

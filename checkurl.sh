#!/bin/bash

# Our check url function used for assignment 2 / task 3 to check if the frontend of a WordPress website is live
# $1 is the first argument when this program is called eg ./checkurl.sh http://13.236.116.252/

if curl -s --head  --request GET $1 | grep [4-5][0-9][0-9] > /dev/null # Check for 4xx/5xx error on the page
then
  export problemIP=$1 # Store the Public IP as an environment variable
  export problemError=$(curl -s --head  --request GET $1 | grep [4-5][0-9][0-9] | sed -E 's/([a-zA-Z\/\s]*.\.. |[a-zA-Z\/\s])//g') # Store the error as an environment variable
  ansible-playbook email.yml #Send the error notification email
fi
if curl -s --head  --request GET $1 | grep "200" > /dev/null # Check for 200 success on the page in which case we check the homepage's outbound links
then
  wget -O - $1 | \
  grep -o '<a href=['"'"'"][^"'"'"']*['"'"'"]' | \
  sed -e 's/^<a href=["'"'"']//' -e 's/["'"'"']$//' | \
  awk '!a[$0]++' | while read line
  do
    if [[ $line == /* ]] # If our line starts with a slash it's a relative url and we should append our Public IP onto it
    then
      line="$1$line" # Merge our Public IP and this relative path link back into the line variable
    fi
  	if curl -s --head  --request GET $line | grep [4-5][0-9][0-9] > /dev/null # Check for 404 error on the page
  	then
      export problemIP=$1 # Store the Public IP as an environment variable
      export problemError="broken_link_$line" # Store the error as an environment variable
      ansible-playbook email.yml #Send the error notification email
  	fi
  done
fi

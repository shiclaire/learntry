#!/usr/bin/env bash

# TASK 1 INSTALL FILE
# This file assumes the following about our instance:
# - That it's running on Linux 2 AMI (might work on other one's too though, not sure if anything about this is unique to Linux 2 AMI)

# LAMP SETUP
sudo yum update -y && # Install package updates
sudo amazon-linux-extras install -y lamp-mariadb10.2-php7.2 php7.2 # Install PHP
sudo yum install -y httpd mariadb-server # Installing Apache & MariaDB
sudo systemctl start httpd # Start the Apache server
sudo systemctl enable httpd # Start the Apache server at each system boot
sudo usermod -a -G apache ec2-user # Adding ourselves as a user to the apache group
sudo chown -R ec2-user:apache /var/www # Giving the apache group ownership of /var/www
sudo chmod 2775 /var/www && find /var/www -type d -exec sudo chmod 2775 {} \; # Changing directory permissions
find /var/www -type f -exec sudo chmod 0664 {} \; # Add group write permissions to /var/www
sudo systemctl start mariadb # Start the database server
printf '\ny\ntest\ntest\ny\ny\ny\ny\n' | sudo mysql_secure_installation # Secure SQL installation
sudo systemctl enable mariadb # Start the database server at each system boot

# WP SETUP
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar # Download the WP CLI
chmod +x wp-cli.phar # Make the WP CLI executable
sudo mv wp-cli.phar /usr/local/bin/wp # Put it in our PATH so we can just call "wp"
cd /var/www/html # Navigate to our html directory
wp core download # Download WordPress Core
wp core config --dbname=wpdb --dbuser=root --dbpass=test # Generate our config file
wp db create # Create the database for our WordPress site
IP=$(curl http://169.254.169.254/latest/meta-data/public-ipv4) # Get the server's public IP
wp core install --url="http://$IP" --title="Assignment 1 WordPress Site" --admin_user="group_1" --admin_password="alpha wario salamander" --admin_email="test@test.co.nz" # Install WordPress and set up our user

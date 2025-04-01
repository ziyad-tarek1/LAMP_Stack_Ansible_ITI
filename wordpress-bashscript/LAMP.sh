#!/bin/bash

# Update system packages
sudo yum update -y

# Install Apache (HTTPD)
sudo yum install -y httpd
sudo systemctl start httpd
sudo systemctl enable httpd

# Install MariaDB (MySQL)
sudo yum install -y mariadb105-server
sudo systemctl start mariadb
sudo systemctl enable mariadb

# Secure MariaDB installation
sudo mysql_secure_installation <<EOF

y
StrongRootPassword
StrongRootPassword
y
y
y
y
EOF

# Create WordPress database and user
sudo mysql -u root -pStrongRootPassword -e "CREATE DATABASE wordpress;"
sudo mysql -u root -pStrongRootPassword -e "CREATE USER 'wpuser'@'localhost' IDENTIFIED BY 'StrongPassword!';"
sudo mysql -u root -pStrongRootPassword -e "GRANT ALL PRIVILEGES ON wordpress.* TO 'wpuser'@'localhost';"
sudo mysql -u root -pStrongRootPassword -e "FLUSH PRIVILEGES;"

# Install PHP 8.2 and required modules
sudo dnf install -y php8.2
sudo dnf install -y php-mysqlnd php-fpm php-json php-mbstring php-xml php-cli php-gd php-curl
sudo systemctl restart httpd

# Download and configure WordPress
cd /var/www/html
sudo curl -O https://wordpress.org/latest.tar.gz
sudo tar -xzf latest.tar.gz
sudo mv wordpress/* .
sudo rm -rf wordpress latest.tar.gz

# Set correct permissions
sudo chown -R apache:apache /var/www/html
sudo chmod -R 755 /var/www/html

# Configure WordPress database connection
sudo cp wp-config-sample.php wp-config.php
sudo sed -i "s/database_name_here/wordpress/;s/username_here/wpuser/;s/password_here/StrongPassword!/;" /var/www/html/wp-config.php

# Restart services
sudo systemctl restart httpd
sudo systemctl restart mariadb
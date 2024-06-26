#!/bin/bash

# Update the system and install Squid and Apache Utils
sudo apt update
sudo apt install -y squid apache2-utils

# Backup the original Squid configuration file
sudo cp /etc/squid/squid.conf /etc/squid/squid.conf.original

# Create a user and password
sudo htpasswd -b -c /etc/squid/passwd nathando nathanDo2024

# Configure Squid to use authentication and set the listening port
echo "auth_param basic program /usr/lib/squid/basic_ncsa_auth /etc/squid/passwd
auth_param basic realm proxy
acl authenticated proxy_auth REQUIRED
http_access allow authenticated
http_access deny all
http_port 0.0.0.0:3128" | sudo tee /etc/squid/squid.conf

# Restart and enable Squid service
sudo systemctl enable squid
sudo systemctl restart squid

# Print completion message
echo "Squid proxy server has been installed and configured with user authentication and proper port settings."

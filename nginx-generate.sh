#!/bin/bash

# Prompt user for action
echo "Select an option:"
echo "1. Proxy to a port"
echo "2. Serve static files from a directory"
read -p "Enter your choice (1 or 2): " choice

# Define the Nginx config file path
read -p "Enter the domain key (e.g., api.mmobank.net or console.mmobank.net): " domain
nginx_conf_file="/etc/nginx/sites-enabled/${domain}.conf"

# Generate the Nginx configuration based on the choice
if [ "$choice" -eq 1 ]; then
    read -p "Enter the port number: " port

    cat <<EOL > $nginx_conf_file
server {
    listen 80;
    server_name ${domain};

    location / {
        proxy_pass http://localhost:${port};
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
    }
}
EOL

elif [ "$choice" -eq 2 ]; then
    read -p "Enter the path to the static files directory (e.g., /var/www/html): " static_dir

    cat <<EOL > $nginx_conf_file
server {
    listen 80;
    server_name ${domain};

    location / {
        root ${static_dir};
        index index.html index.htm;
        try_files \$uri \$uri/ =404;
    }
}
EOL

else
    echo "Invalid choice. Please run the script again."
    exit 1
fi

# Output success message
echo "Nginx configuration file created at: $nginx_conf_file"

# Test Nginx configuration
sudo nginx -t

# Reload Nginx to apply changes
sudo systemctl reload nginx

echo "Nginx has been reloaded with the new configuration."

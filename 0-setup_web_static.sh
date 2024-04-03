#!/usr/bin/env bash
# Script to set up web servers for the deployment of web_static

# Check if Nginx is installed
if ! dpkg -l nginx >/dev/null 2>&1; then
    sudo apt-get update -y -qq
    sudo apt-get install -y nginx
fi

# Create directories if they don't exist
sudo mkdir -p /data/web_static/releases/test /data/web_static/shared/

# Create a fake HTML file
echo "<h2 style='text-align:center'>Welcome to k_mmadu.tech-hub</h2>" | sudo tee /data/web_static/releases/test/index.html >/dev/null

# Create a symbolic link
sudo ln -sf /data/web_static/releases/test/ /data/web_static/current

# Give ownership to ubuntu user and group
sudo chown -R ubuntu:ubuntu /data/

# Backup Nginx configuration
sudo cp /etc/nginx/sites-available/default /etc/nginx/sites-available/default.backup

# Update the Nginx configuration
sudo sed -i '/^server {/a \ \n\tlocation /hbnb_static/ {\n\t\talias /data/web_static/current/;\n\t}\n' /etc/nginx/sites-available/default

# Restart Nginx
sudo service nginx restart

echo "Completed without error"


#!/usr/bin/env bash

# Install Nginx if it's not already installed
apt-get update
apt-get -y install nginx

# Create necessary directories if they don't exist
mkdir -p /data/web_static/releases/test
mkdir -p /data/web_static/shared

# Create a fake HTML file for testing Nginx configuration
echo "<html>
  <head>
  </head>
  <body>
    Holberton School
  </body>
</html>" > /data/web_static/releases/test/index.html

# Create or update symbolic link
rm -rf /data/web_static/current
ln -s /data/web_static/releases/test/ /data/web_static/current

# Give ownership of the /data/ folder to the ubuntu user and group
chown -R ubuntu:ubuntu /data/

# Update Nginx configuration to serve the content of /data/web_static/current/ to hbnb_static
config_path="/etc/nginx/sites-available/default"
echo "
server {
    listen 80;
    listen [::]:80 default_server;

    server_name _;

    location /hbnb_static/ {
        alias /data/web_static/current/;
    }

    location / {
        try_files \$uri \$uri/ =404;
    }
}" > "$config_path"

# Restart Nginx
service nginx restart

exit 0


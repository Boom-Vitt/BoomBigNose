#!/bin/sh
set -e

echo "Starting BoomBigNose services on Railway..."

# Create necessary directories
mkdir -p /var/log/supervisor
mkdir -p /var/run
mkdir -p /var/www/html

# Create n8n config directory with proper permissions
mkdir -p /home/n8n/.n8n
chmod -R 755 /home/n8n/.n8n
chown -R n8n:n8n /home/n8n/.n8n
chown -R n8n:n8n /home/n8n

# Don't create a config file, use environment variables instead
mkdir -p /home/n8n/.n8n
chown -R n8n:n8n /home/n8n/.n8n

# Create health check files
echo "OK" > /var/www/html/ping
echo "<html><body><h1>BoomBigNose</h1><p>Railway deployment with n8n</p></body></html>" > /var/www/html/index.html

# Start nginx in the background
nginx &

# Start n8n as the n8n user with explicit environment variables
su -c "cd /home/n8n && HOME=/home/n8n N8N_USER_FOLDER=/home/n8n/.n8n DB_TYPE=sqlite DB_SQLITE_DATABASE=/home/n8n/.n8n/database.sqlite n8n start" n8n

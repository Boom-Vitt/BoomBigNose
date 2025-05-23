#!/bin/sh
set -e

# Create necessary directories
mkdir -p /var/log/supervisor
mkdir -p /var/run
mkdir -p /var/www/html

# Create n8n config directory with proper permissions
mkdir -p /home/node/.n8n
chown -R node:node /home/node/.n8n

# Create health check files
echo "OK" > /var/www/html/ping
echo "<html><body><h1>BoomBigNose</h1><p>Railway deployment with n8n</p></body></html>" > /var/www/html/index.html

# Start supervisord
exec supervisord -c /etc/supervisor/conf.d/supervisord.conf

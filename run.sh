#!/bin/sh
set -e

# Create necessary directories
mkdir -p /var/log/supervisor
mkdir -p /var/run
mkdir -p /var/www/html

# Create n8n config directory with proper permissions
mkdir -p /home/node/.n8n
chmod -R 755 /home/node/.n8n
chown -R node:node /home/node/.n8n
chown -R node:node /home/node

# Prevent n8n from trying to use /root/.n8n
if [ -d "/root/.n8n" ]; then
  rm -rf /root/.n8n
fi
mkdir -p /root/.n8n
ln -sf /home/node/.n8n /root/.n8n
chown -R node:node /root/.n8n

# Create health check files
echo "OK" > /var/www/html/ping
echo "<html><body><h1>BoomBigNose</h1><p>Railway deployment with n8n</p></body></html>" > /var/www/html/index.html

# Start supervisord
exec supervisord -c /etc/supervisor/conf.d/supervisord.conf

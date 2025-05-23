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

# Create n8n config file
cat > /home/n8n/.n8n/config << EOF
{
  "database": {
    "type": "sqlite",
    "sqlite": {
      "database": "/home/n8n/.n8n/database.sqlite"
    }
  }
}
EOF
chown -R n8n:n8n /home/n8n/.n8n

# Create health check files
echo "OK" > /var/www/html/ping
echo "<html><body><h1>BoomBigNose</h1><p>Railway deployment with n8n</p></body></html>" > /var/www/html/index.html

echo "Starting supervisord..."
exec supervisord -c /etc/supervisor/conf.d/supervisord.conf

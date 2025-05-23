#!/bin/bash
set -e

echo "Starting BoomBigNose services on Railway..."

# Create necessary directories
mkdir -p /app/health /usr/share/nginx/html

# Update health check with current timestamp
cat > /app/health/index.html << EOF
<!DOCTYPE html>
<html>
<head>
    <title>BoomBigNose Health Check</title>
</head>
<body>
    <h1>BoomBigNose Services</h1>
    <p>Status: Running</p>
    <p>Time: $(date)</p>
    <p>Environment: Railway</p>
    <p>Project ID: 3c5932b7-b548-4802-b39f-55d7ccfb545d</p>
</body>
</html>
EOF

# Create ping endpoint for Railway health checks
echo "OK" > /app/health/ping
echo "OK" > /usr/share/nginx/html/ping

# Update health.json with current timestamp
cat > /usr/share/nginx/html/health.json << EOF
{
  "status": "ok",
  "timestamp": "$(date -u +"%Y-%m-%dT%H:%M:%SZ")",
  "service": "BoomBigNose",
  "version": "1.0.0"
}
EOF

# Configure nginx to serve the health check endpoint
cat > /etc/nginx/conf.d/default.conf << EOF
server {
    listen 8000 default_server;
    server_name _;

    location / {
        root /usr/share/nginx/html;
        index index.html;
    }

    # Health check endpoint for Railway
    location = /ping {
        add_header Content-Type text/plain;
        return 200 'OK';
    }

    # JSON health check
    location = /health {
        root /usr/share/nginx/html;
        try_files /health.json =200;
        default_type application/json;
    }
}
EOF

# Start nginx
echo "Starting nginx..."
nginx

# Keep container running
echo "All services are up and running!"
echo "Health check available at: http://localhost:8000/ping"
tail -f /var/log/nginx/access.log

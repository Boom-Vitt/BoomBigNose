#!/bin/bash
set -e

echo "Starting BoomBigNose services on Railway..."

# Update health check with current timestamp
mkdir -p /app/health
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

# Update health.json with current timestamp
cat > /usr/share/nginx/html/health.json << EOF
{
  "status": "ok",
  "timestamp": "$(date -u +"%Y-%m-%dT%H:%M:%SZ")",
  "service": "BoomBigNose",
  "version": "1.0.0"
}
EOF

# Start nginx
echo "Starting nginx..."
nginx

# Start Python health check server
echo "Starting health check server..."
python3 -m http.server 8000 --directory /app/health &

# Keep container running
echo "All services are up and running!"
echo "Health check available at: http://localhost:8000"
tail -f /var/log/nginx/access.log

#!/bin/bash
set -e

echo "Starting BoomBigNose Template Landing Page"

# Start nginx
echo "Starting nginx..."
nginx

# Keep the container running
echo "Server is running at http://localhost:8000"
tail -f /var/log/nginx/access.log

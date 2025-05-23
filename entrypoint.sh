#!/bin/bash
set -e

# Load environment variables from .env file
echo "Loading environment variables from .env file"
export $(grep -v '^#' .env | xargs -r)

# Start Docker daemon
echo "Starting Docker daemon..."
dockerd &
sleep 5

# Create necessary directories
echo "Creating necessary directories..."
mkdir -p volumes/api volumes/db volumes/functions volumes/logs volumes/storage

# Copy kong.yml.template if it doesn't exist
if [ ! -f volumes/api/kong.yml.template ]; then
  echo "Setting up Kong API Gateway configuration..."
  cp -f volumes/api/kong.yml.template volumes/api/kong.yml.template
fi

# Start services with docker-compose
echo "Starting services with docker-compose..."
docker-compose up -d

# Wait for MinIO to be ready
echo "Waiting for MinIO to be ready..."
until $(curl --output /dev/null --silent --head --fail http://localhost:9000); do
  printf '.'
  sleep 5
done

# Set up MinIO bucket
echo "Setting up MinIO bucket..."
./setup-minio.sh

# Wait for PostgreSQL to be ready
echo "Waiting for PostgreSQL to be ready..."
until docker exec $(docker ps -q -f name=postgres) pg_isready -U postgres; do
  printf '.'
  sleep 5
done

# Wait for Redis to be ready
echo "Waiting for Redis to be ready..."
until docker exec $(docker ps -q -f name=redis) redis-cli ping | grep -q PONG; do
  printf '.'
  sleep 5
done

# Wait for Supabase DB to be ready
echo "Waiting for Supabase DB to be ready..."
until docker exec $(docker ps -q -f name=supabase-db) pg_isready -U postgres; do
  printf '.'
  sleep 5
done

# Wait for Ollama to be ready
echo "Waiting for Ollama to be ready..."
until $(curl --output /dev/null --silent --head --fail http://localhost:11434/api/tags); do
  printf '.'
  sleep 5
done

# Wait for n8n to be ready
echo "Waiting for n8n to be ready..."
until $(curl --output /dev/null --silent --head --fail http://localhost:5678); do
  printf '.'
  sleep 5
done

# Create a simple health check endpoint
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
</body>
</html>
EOF

# Start a simple HTTP server for health checks
echo "Starting health check server..."
cd /app/health
python3 -m http.server 8000 &

# Keep container running
echo "All services are up and running!"
echo "You can access n8n at: http://localhost:5678"
echo "Health check available at: http://localhost:8000"
tail -f /dev/null

#!/bin/sh
set -e

# Start Docker daemon
dockerd &
sleep 5

# Start services with docker-compose
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

# Keep container running
echo "All services are up and running!"
tail -f /dev/null

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

# Keep container running
echo "All services are up and running!"
tail -f /dev/null

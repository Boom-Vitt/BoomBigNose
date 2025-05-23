FROM docker:20.10.16-dind

# Install Docker Compose and other dependencies
RUN apk add --no-cache docker-compose python3 py3-pip curl postgresql-client redis bash

# Set working directory
WORKDIR /app

# Copy docker-compose.yml and environment variables
COPY docker-compose.yml .
COPY .env .

# Copy entrypoint script
COPY entrypoint.sh .
RUN chmod +x entrypoint.sh

# Set up MinIO bucket on startup
COPY setup-minio.sh .
RUN chmod +x setup-minio.sh

# Copy volumes directory
COPY volumes ./volumes

# Expose ports
EXPOSE 5678 8080 8880 9000 9001 5432 6379 5433 3000 11434 8000 8443 4000

# Set entrypoint
ENTRYPOINT ["/app/entrypoint.sh"]

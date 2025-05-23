FROM docker:20.10.16-dind

# Install Docker Compose
RUN apk add --no-cache docker-compose python3 py3-pip curl

# Set working directory
WORKDIR /app

# Copy docker-compose.yml
COPY docker-compose.yml .

# Copy entrypoint script
COPY entrypoint.sh .
RUN chmod +x entrypoint.sh

# Set up MinIO bucket on startup
COPY setup-minio.sh .
RUN chmod +x setup-minio.sh

# Expose ports
EXPOSE 8080 8880 9000 9001

# Set entrypoint
ENTRYPOINT ["/app/entrypoint.sh"]

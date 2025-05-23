FROM docker:20.10.16-dind

# Install Docker Compose and other dependencies
RUN apk add --no-cache docker-compose python3 py3-pip curl postgresql-client redis bash net-tools

# Set working directory
WORKDIR /app

# Copy docker-compose.yml
COPY docker-compose.yml .

# Create default .env file
RUN echo "# General Settings\nPOSTGRES_PASSWORD=postgres\nPOSTGRES_USER=postgres\nPOSTGRES_DB=postgres\nPOSTGRES_PORT=5432\nPOSTGRES_HOST=db\n\n# JWT Settings\nJWT_SECRET=super-secret-jwt-token-with-at-least-32-characters-long\nJWT_EXPIRY=3600\nANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0\nSERVICE_ROLE_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImV4cCI6MTk4MzgxMjk5Nn0.EGIM96RAZx35lJzdJsyH-qQwv8Hdp7fsn3W0YpN81IU\n\n# MinIO Settings\nMINIO_ROOT_USER=admin\nMINIO_ROOT_PASSWORD=password123\n\n# NCA-Toolkit Settings\nAPI_KEY=thekey\nS3_ENDPOINT_URL=http://minio:9000\nS3_ACCESS_KEY=admin\nS3_SECRET_KEY=password123\nS3_BUCKET_NAME=nca-toolkit\nS3_REGION=None" > .env

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

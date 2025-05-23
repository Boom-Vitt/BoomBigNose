#!/bin/sh
set -e

# Install MinIO client
wget https://dl.min.io/client/mc/release/linux-amd64/mc -O /usr/local/bin/mc
chmod +x /usr/local/bin/mc

# Configure MinIO client
mc alias set myminio http://localhost:9000 admin password123

# Create bucket if it doesn't exist
if ! mc ls myminio | grep -q nca-toolkit; then
  mc mb myminio/nca-toolkit
  echo "Bucket 'nca-toolkit' created successfully"
else
  echo "Bucket 'nca-toolkit' already exists"
fi

# Set bucket policy to public (if needed)
# mc policy set download myminio/nca-toolkit

echo "MinIO setup completed"

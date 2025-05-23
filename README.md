# NCA-Toolkit Railway Template

This template deploys a multi-container application on Railway, consisting of:

1. **NCA-Toolkit** - A No-Code Architects Toolkit
2. **MinIO** - Object Storage Service
3. **Kokoro TTS CPU** - Text-to-Speech Service

## One-Click Deployment

[![Deploy on Railway](https://railway.app/button.svg)](https://railway.app/template/YOUR_TEMPLATE_ID)

## Services

### NCA-Toolkit
- **Image**: stephengpope/no-code-architects-toolkit:latest
- **Port**: 8080
- **Description**: A No-Code Architects Toolkit for building applications without writing code

### MinIO
- **Image**: quay.io/minio/minio
- **Ports**: 9000 (API) and 9001 (Console)
- **Description**: Object storage service compatible with Amazon S3 API

### Kokoro TTS
- **Image**: ghcr.io/remsky/kokoro-fastapi-cpu:v0.2.2
- **Port**: 8880
- **Description**: Text-to-Speech service

## Configuration

### Environment Variables

You can customize the following environment variables:

#### NCA-Toolkit
- `API_KEY`: Authentication key for the toolkit (default: "thekey")
- `S3_BUCKET_NAME`: MinIO bucket name (default: "nca-toolkit")

#### MinIO
- `MINIO_ROOT_USER`: MinIO admin username (default: "admin")
- `MINIO_ROOT_PASSWORD`: MinIO admin password (default: "password123")

## Accessing the Services

After deployment, you can access the services at:

- **NCA-Toolkit**: `https://<your-railway-url>:8080`
- **MinIO API**: `https://<your-railway-url>:9000`
- **MinIO Console**: `https://<your-railway-url>:9001`
- **Kokoro TTS**: `https://<your-railway-url>:8880`

## Security Considerations

For production use, please change the default credentials:

1. Update the `API_KEY` for NCA-Toolkit
2. Change the MinIO root user and password
3. Update the S3 access and secret keys in the NCA-Toolkit configuration

## Local Development

To run this template locally:

```bash
git clone https://github.com/your-username/nca-toolkit-template.git
cd nca-toolkit-template
docker-compose up -d
```

## License

This template is provided as-is. Please refer to the individual services for their respective licenses.

## Support

For issues with the template itself, please open an issue on the GitHub repository.
For issues with the individual services, please refer to their respective documentation:

- [NCA-Toolkit](https://github.com/stephengpope/no-code-architects-toolkit)
- [MinIO](https://min.io/docs/minio/container/index.html)
- [Kokoro TTS](https://github.com/remsky/kokoro)

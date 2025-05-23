# BoomBigNose Railway Template

This template provides a comprehensive development environment with multiple services:

1. **n8n** - Workflow Automation Tool
2. **NCA-Toolkit** - A No-Code Architects Toolkit
3. **MinIO** - Object Storage Service
4. **Kokoro TTS CPU** - Text-to-Speech Service
5. **PostgreSQL** - Relational Database
6. **Redis** - In-memory Data Store
7. **Supabase** - Open Source Firebase Alternative
8. **Ollama** - Open Source LLM Runner

All services are connected to a shared Docker network, allowing them to be easily used together with n8n workflows.

## Railway Deployment

This template provides a landing page on Railway that links to the GitHub repository where you can find the complete Docker Compose setup for local development.

## One-Click Deployment

[![Deploy on Railway](https://railway.app/button.svg)](https://railway.app/template/TEMPLATE_ID_FROM_RAILWAY)

## Services

### n8n
- **Image**: n8nio/n8n:latest
- **Port**: 5678
- **Description**: Workflow automation tool that allows you to connect various services and automate tasks

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

### PostgreSQL
- **Image**: postgres:15
- **Port**: 5432
- **Description**: Powerful, open source relational database system

### Redis
- **Image**: redis:7
- **Port**: 6379
- **Description**: In-memory data structure store, used as a database, cache, and message broker

### Supabase
- **Image**: supabase/postgres:15.1.0.117 (Database) and supabase/studio:latest (Studio)
- **Ports**: 5433 (Database) and 3000 (Studio)
- **Description**: Open source Firebase alternative with PostgreSQL database and web-based admin panel

### Ollama
- **Image**: ollama/ollama:latest
- **Port**: 11434
- **Description**: Run open-source large language models locally

## Configuration

### Environment Variables

You can customize the following environment variables:

#### NCA-Toolkit
- `API_KEY`: Authentication key for the toolkit (default: "thekey")
- `S3_BUCKET_NAME`: MinIO bucket name (default: "nca-toolkit")

#### MinIO
- `MINIO_ROOT_USER`: MinIO admin username (default: "admin")
- `MINIO_ROOT_PASSWORD`: MinIO admin password (default: "password123")

#### PostgreSQL
- `POSTGRES_USER`: PostgreSQL username (default: "postgres")
- `POSTGRES_PASSWORD`: PostgreSQL password (default: "postgres")
- `POSTGRES_DB`: PostgreSQL database name (default: "postgres")

#### Supabase
- `POSTGRES_USER`: Supabase PostgreSQL username (default: "postgres")
- `POSTGRES_PASSWORD`: Supabase PostgreSQL password (default: "postgres")
- `POSTGRES_DB`: Supabase PostgreSQL database name (default: "postgres")

#### n8n
- `N8N_BASIC_AUTH_USER`: n8n admin username (default: "admin")
- `N8N_BASIC_AUTH_PASSWORD`: n8n admin password (default: "password")
- `DB_POSTGRESDB_DATABASE`: PostgreSQL database for n8n (default: "n8n")
- `DB_POSTGRESDB_USER`: PostgreSQL username for n8n (default: "postgres")
- `DB_POSTGRESDB_PASSWORD`: PostgreSQL password for n8n (default: "postgres")

## Accessing the Services

After deployment, you can access the services at:

- **n8n**: `https://<your-railway-url>:5678`
- **NCA-Toolkit**: `https://<your-railway-url>:8080`
- **MinIO API**: `https://<your-railway-url>:9000`
- **MinIO Console**: `https://<your-railway-url>:9001`
- **Kokoro TTS**: `https://<your-railway-url>:8880`
- **PostgreSQL**: `https://<your-railway-url>:5432`
- **Redis**: `https://<your-railway-url>:6379`
- **Supabase Database**: `https://<your-railway-url>:5433`
- **Supabase Studio**: `https://<your-railway-url>:3000`
- **Ollama API**: `https://<your-railway-url>:11434`

## Security Considerations

For production use, please change the default credentials:

1. Update the `API_KEY` for NCA-Toolkit
2. Change the MinIO root user and password
3. Update the S3 access and secret keys in the NCA-Toolkit configuration
4. Change the PostgreSQL username and password
5. Change the Supabase PostgreSQL username and password
6. Update the Supabase JWT keys for production use
7. Change the n8n admin username and password

## Local Development

To run this template locally:

```bash
git clone https://github.com/your-username/BoomBigNose.git
cd BoomBigNose
docker-compose up -d
```

## License

This template is provided as-is. Please refer to the individual services for their respective licenses.

## Support

For issues with the template itself, please open an issue on the GitHub repository.
For issues with the individual services, please refer to their respective documentation:

- [n8n](https://docs.n8n.io/)
- [NCA-Toolkit](https://github.com/stephengpope/no-code-architects-toolkit)
- [MinIO](https://min.io/docs/minio/container/index.html)
- [Kokoro TTS](https://github.com/remsky/kokoro)
- [PostgreSQL](https://www.postgresql.org/docs/)
- [Redis](https://redis.io/documentation)
- [Supabase](https://supabase.com/docs)
- [Ollama](https://ollama.com/)

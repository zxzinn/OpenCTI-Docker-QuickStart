# OpenCTI Docker Deployment Guide

<div align="right">

**English** | [繁體中文](README.md)

</div>

## Introduction
This project contains Docker Compose configuration files and environment setup scripts for deploying OpenCTI (Open Cyber Threat Intelligence), an open-source threat intelligence platform.

## Prerequisites
- Docker
- Docker Compose
- Python 3.x
- OpenSSL

## Quick Start

1. Clone this repository:
```bash
git clone [your-repository-url]
cd [repository-name]
```

2. Generate environment configuration:
   - Windows users: Double-click `generate_env.bat`
   - Linux/Mac users: Run `./generate_env.sh`

3. Start services:
```bash
docker-compose up -d
```

4. Access the platform:
   Open your browser and navigate to `http://localhost:8080`

## File Description

- `docker-compose.yml`: Docker services configuration file
- `.env.example`: Environment variables template
- `generate_env.bat`: Windows environment configuration generator
- `generate_env.sh`: Linux/Mac environment configuration generator

## Environment Configuration

The environment configuration includes:
- OpenCTI platform configuration
- MinIO configuration (Object Storage)
- RabbitMQ configuration (Message Queue)
- ElasticSearch configuration
- Various connector configurations (MITRE, AlienVault, etc.)

## Security Considerations

1. Never commit the `.env` file containing sensitive information to version control
2. Regularly rotate passwords and API keys
3. Ensure strong passwords are used in production environments

## Troubleshooting

If you encounter issues:

1. Verify all required services are running:
```bash
docker-compose ps
```

2. Check service logs:
```bash
docker-compose logs [service-name]
```

3. Verify environment variables are set correctly:
```bash
docker-compose config
```

## Contributing

Contributions via Pull Requests and Issues are welcome. Before submitting, please:

1. Ensure code follows project conventions
2. Update relevant documentation
3. Add necessary tests

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details

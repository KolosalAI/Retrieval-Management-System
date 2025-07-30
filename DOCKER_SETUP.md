# Docker Setup Guide

This guide explains how to set up and run the Kolosal AI Retrieval Management System using Docker Compose.

## Prerequisites

- [Docker](https://docs.docker.com/get-docker/) (version 20.10 or later)
- [Docker Compose](https://docs.docker.com/compose/install/) (version 2.0 or later)
- At least 4GB of available RAM
- At least 10GB of free disk space

## Quick Start

### 1. Clone the Repository

```bash
git clone https://github.com/KolosalAI/Retrieval-Management-System.git
cd Retrieval-Management-System
```

### 2. Start Services

```bash
docker-compose up -d
```

That's it! All services will be built directly from their GitHub repositories.

## Architecture Overview

The system consists of 5 main services built directly from GitHub:

### Core Services

1. **Kolosal Server** (Port 8084)
   - Built from [kolosal-server](https://github.com/KolosalAI/kolosal-server) (docker branch)
   - Handles LLM inference, embeddings, and RAG operations

2. **Dashboard** (Port 3000)
   - Built from [Kolosal-RMS-Dashboard](https://github.com/KolosalAI/Kolosal-RMS-Dashboard)
   - Unified control panel for all services

3. **Qdrant** (Port 6333)
   - Official Qdrant Docker image
   - Stores document embeddings for RAG operations

4. **MarkItDown** (Port 8001)
   - Built from [Kolosal-RMS-MarkItDown](https://github.com/KolosalAI/Kolosal-RMS-MarkItDown)
   - Converts documents to markdown

5. **SearXNG** (Port 8090)
   - Built from [searxng-docker](https://github.com/searxng/searxng-docker)
   - Privacy-respecting internet search

## Service URLs

After starting services, access them at:

- **Dashboard**: <http://localhost:3000>
- **Kolosal Server**: <http://localhost:8084>
- **Qdrant**: <http://localhost:6333>
- **SearXNG**: <http://localhost:8090>
- **MarkItDown**: <http://localhost:8001>

## Managing Services

### Start all services
```bash
docker-compose up -d
```

### Stop all services
```bash
docker-compose down
```

### View logs
```bash
# All services
docker-compose logs -f

# Specific service
docker-compose logs -f kolosal-server
```

### Restart a service
```bash
docker-compose restart kolosal-server
```

### Rebuild a service (with latest code)
```bash
docker-compose build kolosal-server --no-cache
docker-compose up -d kolosal-server
```

## Adding AI Models

1. Download GGUF format models to the `models/` directory
2. Restart kolosal-server: `docker-compose restart kolosal-server`
3. Models will be automatically detected and available through the API

Example models directory:
```
models/
├── llama-2-7b-chat.q4_0.gguf
├── mistral-7b-instruct.q4_0.gguf
└── codellama-7b-instruct.q4_0.gguf
```

## Troubleshooting

### Common Issues

1. **Port conflicts**: Check if ports 3000, 6333, 8084, 8090, 8001 are available
2. **Memory issues**: Ensure at least 4GB RAM is available
3. **Build failures**: Try `docker-compose build --no-cache`

### Service Health Checks
```bash
# Check service status
docker-compose ps

# Test service endpoints
curl http://localhost:8084/health  # Kolosal Server
curl http://localhost:6333/health  # Qdrant
curl http://localhost:8001/health  # MarkItDown
```

## Data Storage

### Persistent Volumes
- `qdrant_storage`: Qdrant vector database data
- `redis_data`: Redis cache data
- `./models`: AI model files (host directory)

## Benefits of This Approach

- **Simple Setup**: Just `git clone` and `docker-compose up -d`
- **Always Latest**: Builds from latest GitHub repositories
- **No Submodules**: No need to manage git submodules
- **Clean Structure**: Minimal files in main repository

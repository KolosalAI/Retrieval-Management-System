# Qdrant Initialization

This directory contains the initialization setup for Qdrant to automatically create the "documents" collection when the system starts.

## What it does

The initialization service:
1. Waits for Qdrant to be ready
2. Checks if the "documents" collection already exists
3. Creates the "documents" collection if it doesn't exist

## Collection Configuration

The "documents" collection is created with the following configuration:
- **Vector size**: 1536 (compatible with OpenAI embeddings)
- **Distance metric**: Cosine similarity
- **Optimizers**: Default segment number of 2
- **Replication factor**: 1

## Files

- `init.py` - Main initialization script
- `Dockerfile` - Container configuration for the init service
- `requirements.txt` - Python dependencies

## Usage

The initialization service runs automatically when you start the Docker Compose stack. It will:
- Run once when the system starts
- Exit after successful initialization
- Not restart automatically (restart: "no")

To manually run the initialization:
```bash
docker-compose up qdrant-init
```

## Environment Variables

- `QDRANT_URL` - URL of the Qdrant service (default: http://qdrant:6333)

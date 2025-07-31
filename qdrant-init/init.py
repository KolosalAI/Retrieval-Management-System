#!/usr/bin/env python3
"""
Qdrant initialization script to create the 'documents' collection.
This script runs after Qdrant starts to ensure the collection exists.
"""

import time
import requests
import json
import sys
import os
from typing import Dict, Any

def wait_for_qdrant(url: str, max_retries: int = 30) -> bool:
    """Wait for Qdrant to be available."""
    for i in range(max_retries):
        try:
            response = requests.get(f"{url}/collections")
            if response.status_code == 200:
                print("✅ Qdrant is ready!")
                return True
        except requests.exceptions.RequestException:
            pass
        
        print(f"⏳ Waiting for Qdrant to be ready... ({i+1}/{max_retries})")
        time.sleep(2)
    
    return False

def collection_exists(url: str, collection_name: str) -> bool:
    """Check if a collection exists."""
    try:
        response = requests.get(f"{url}/collections/{collection_name}")
        return response.status_code == 200
    except requests.exceptions.RequestException:
        return False

def create_documents_collection(url: str) -> bool:
    """Create the documents collection with appropriate configuration."""
    collection_config = {
        "vectors": {
            "size": 1536,  # Standard OpenAI embedding size
            "distance": "Cosine"
        },
        "optimizers_config": {
            "default_segment_number": 2
        },
        "replication_factor": 1
    }
    
    try:
        response = requests.put(
            f"{url}/collections/documents",
            headers={"Content-Type": "application/json"},
            data=json.dumps(collection_config)
        )
        
        if response.status_code in [200, 201]:
            print("✅ Collection 'documents' created successfully!")
            return True
        else:
            print(f"❌ Failed to create collection. Status: {response.status_code}")
            print(f"Response: {response.text}")
            return False
            
    except requests.exceptions.RequestException as e:
        print(f"❌ Error creating collection: {e}")
        return False

def main():
    """Main initialization function."""
    qdrant_url = os.getenv("QDRANT_URL", "http://qdrant:6333")
    
    print("🚀 Starting Qdrant initialization...")
    print(f"🔗 Using Qdrant URL: {qdrant_url}")
    
    # Wait for Qdrant to be ready
    if not wait_for_qdrant(qdrant_url):
        print("❌ Qdrant did not become ready in time")
        sys.exit(1)
    
    # Check if documents collection already exists
    if collection_exists(qdrant_url, "documents"):
        print("ℹ️  Collection 'documents' already exists")
        return
    
    # Create the documents collection
    if create_documents_collection(qdrant_url):
        print("🎉 Qdrant initialization completed successfully!")
    else:
        print("❌ Failed to initialize Qdrant")
        sys.exit(1)

if __name__ == "__main__":
    main()

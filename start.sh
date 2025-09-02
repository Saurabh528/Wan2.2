#!/bin/bash
set -e

# Where to store model
MODEL_DIR="./Wan2.2-S2V-14B"

# Download model weights if not already present
if [ ! -d "$MODEL_DIR" ]; then
  echo "Downloading Wan2.2-S2V-14B weights..."
  huggingface-cli download Wan-AI/Wan2.2-S2V-14B --local-dir $MODEL_DIR
else
  echo "Model already exists, skipping download."
fi

# Start FastAPI app
echo "Starting API..."
uvicorn app:app --host 0.0.0.0 --port 8000

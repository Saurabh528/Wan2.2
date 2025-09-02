# Base image with CUDA + PyTorch (for GPU inference on RunPod)
FROM nvidia/cuda:12.1.1-cudnn8-runtime-ubuntu22.04

# Set working directory
WORKDIR /app

# Install system deps
RUN apt-get update && apt-get install -y \
    git wget curl python3 python3-pip ffmpeg libgl1 \
    && rm -rf /var/lib/apt/lists/*

# Copy repo into container
COPY . /app

# Install Hugging Face CLI + Python deps
# Install Hugging Face CLI + Python deps
RUN pip install --upgrade pip setuptools wheel packaging
RUN pip install -r requirements.txt
RUN pip install "huggingface_hub[cli]" fastapi uvicorn



# Expose FastAPI port
EXPOSE 8000

# Run startup script instead of directly running python
CMD ["bash", "start.sh"]

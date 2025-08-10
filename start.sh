#!/usr/bin/env bash
set -e

echo "Starting installation and launch process..."

# Install Python packages and dependencies (only if needed)
python3 -m pip install --upgrade pip
cd /workspace/stable-diffusion-webui || {
  echo "Cloning stable-diffusion-webui repo..."
  git clone --branch master https://github.com/AUTOMATIC1111/stable-diffusion-webui /workspace/stable-diffusion-webui
  cd /workspace/stable-diffusion-webui
}

# Install requirements
python3 -m pip install -r requirements.txt || true
if [ -d extensions/sd-webui-controlnet ]; then
  python3 -m pip install -r extensions/sd-webui-controlnet/requirements.txt || true
fi

# Install extra python dependencies
python3 -m pip install accelerate transformers safetensors diffusers gradio==3.40.0 pillow==9.5.0
python3 -m pip install --upgrade git+https://github.com/huggingface/diffusers.git
python3 -m pip install safetensors==0.3.0 ldiffusers==0.2.0 bitsandbytes==0.39.0 face_alignment

# Create training directories if missing
mkdir -p /workspace/training/images /workspace/training/captions /workspace/models/lora /workspace/models/dreambooth

# Copy your custom scripts if they exist in cloned repo
if [ -d /workspace/runpod-avatar-trainer1/scripts ]; then
  cp -r /workspace/runpod-avatar-trainer1/scripts/* /workspace/stable-diffusion-webui/scripts/ || true
fi

echo "Launching Web UI..."
python3 launch.py --listen --port 7860 --api

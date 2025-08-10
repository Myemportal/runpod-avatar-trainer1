#!/usr/bin/env bash
set -e

# Step 1 — Clone Stable Diffusion WebUI if not present
if [ ! -d /workspace/stable-diffusion-webui ]; then
    git clone --branch master https://github.com/AUTOMATIC1111/stable-diffusion-webui /workspace/stable-diffusion-webui
fi

# Step 2 — Install dependencies
python3 -m pip install --upgrade pip
cd /workspace/stable-diffusion-webui

# Main requirements
python3 -m pip install -r requirements.txt || true
# ControlNet (if present)
if [ -d extensions/sd-webui-controlnet ]; then
    python3 -m pip install -r extensions/sd-webui-controlnet/requirements.txt || true
fi

# Extra dependencies
python3 -m pip install accelerate transformers safetensors diffusers gradio==3.40.0 pillow==9.5.0
python3 -m pip install --upgrade git+https://github.com/huggingface/diffusers.git
python3 -m pip install safetensors==0.3.0 ldiffusers==0.2.0 bitsandbytes==0.39.0 face_alignment

# Step 3 — Make sure training folders exist
mkdir -p /workspace/training/images /workspace/training/captions /workspace/models/lora /workspace/models/dreambooth

# Step 4 — Copy your custom scripts (if not already copied)
if [ -d /workspace/runpod-avatar-trainer1/scripts ]; then
    cp -r /workspace/runpod-avatar-trainer1/scripts/* /workspace/stable-diffusion-webui/scripts/ || true
fi

# Step 5 — Launch WebUI
python3 launch.py --listen --port 7860 --api

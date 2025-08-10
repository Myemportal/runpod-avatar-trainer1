#!/usr/bin/env bash
set -e

# Upgrade pip first
python3 -m pip install --upgrade pip

# Clone the repo if not already present
if [ ! -d /workspace/stable-diffusion-webui ]; then
  git clone --branch master https://github.com/AUTOMATIC1111/stable-diffusion-webui /workspace/stable-diffusion-webui
fi

cd /workspace/stable-diffusion-webui

# Install general requirements (ignore errors)
python3 -m pip install -r requirements.txt || true

# Install ControlNet extension requirements (ignore errors)
python3 -m pip install -r extensions/sd-webui-controlnet/requirements.txt || true

# Install other necessary packages
python3 -m pip install accelerate transformers safetensors diffusers gradio==3.40.0 pillow==9.5.0

# Upgrade diffusers from latest git branch
python3 -m pip install --upgrade git+https://github.com/huggingface/diffusers.git

# Install specific versions of some packages
python3 -m pip install safetensors==0.3.0 bitsandbytes==0.39.0 face_alignment

# **Force install compatible numpy version to avoid 1.26.2 error**
python3 -m pip install numpy==1.24.4

# Create folders if missing
mkdir -p /workspace/training/images /workspace/training/captions /workspace/models/lora /workspace/models/dreambooth

# Mark installation as done
echo "INSTALL_COMPLETE" > /workspace/.install_done

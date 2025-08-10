#!/usr/bin/env bash
set -e
python3 -m pip install --upgrade pip
if [ ! -d /workspace/stable-diffusion-webui ]; then
  git clone --branch master https://github.com/AUTOMATIC1111/stable-diffusion-webui /workspace/stable-diffusion-webui
fi
cd /workspace/stable-diffusion-webui
python3 -m pip install -r requirements.txt || true
python3 -m pip install -r extensions/sd-webui-controlnet/requirements.txt || true
python3 -m pip install accelerate transformers safetensors diffusers gradio==3.40.0 pillow==9.5.0
python3 -m pip install --upgrade git+https://github.com/huggingface/diffusers.git
python3 -m pip install safetensors==0.3.0 ldiffusers==0.2.0 bitsandbytes==0.39.0 face_alignment
mkdir -p /workspace/training/images /workspace/training/captions /workspace/models/lora /workspace/models/dreambooth
echo "INSTALL_COMPLETE" > /workspace/.install_done

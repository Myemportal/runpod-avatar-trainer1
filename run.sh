#!/usr/bin/env bash
set -e

cd /workspace/stable-diffusion-webui

# Launch the web UI with listen enabled and on port 7860, also enable API
python3 launch.py --listen --port 7860 --api

#!/usr/bin/env bash
set -e
if [ ! -f /workspace/.install_done ]; then
  bash /workspace/install.sh
fi
cd /workspace/stable-diffusion-webui
python3 launch.py --listen --port 7860 --api &
wait -n

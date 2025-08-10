#!/bin/bash
set -e

echo "=== Starting RunPod Avatar Trainer Setup ==="

# Update and install python3-venv if missing
apt-get update && apt-get install -y python3-venv python3-pip

# Create and activate virtual environment (reuse if exists)
if [ ! -d "/workspace/venv" ]; then
    python3 -m venv /workspace/venv
fi
source /workspace/venv/bin/activate

echo "=== Upgrading pip, setuptools, and wheel ==="
pip install --upgrade pip setuptools wheel

echo "=== Installing Python dependencies ==="
# Use requirements.txt from repo
pip install -r /workspace/runpod-avatar-trainer1/requirements.txt

echo "=== Cleaning pip cache to save space ==="
rm -rf ~/.cache/pip

echo "=== Running Avatar Trainer ==="
cd /workspace/runpod-avatar-trainer1

# Launch with listen and port 7860 (exposed by RunPod)
python3 launch.py --listen --port 7860

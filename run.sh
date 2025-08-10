#!/bin/bash

# Update and install python3-venv if needed
apt-get update && apt-get install -y python3-venv python3-pip

# Create and activate virtual environment
python3 -m venv /workspace/venv
source /workspace/venv/bin/activate

# Upgrade pip, setuptools, wheel first
pip install --upgrade pip setuptools wheel

# Install requirements
pip install -r /workspace/runpod-avatar-trainer1/requirements.txt

# Clean pip cache to save space
rm -rf ~/.cache/pip

# Change to repo directory
cd /workspace/runpod-avatar-trainer1

# Run the app with listen flag on port 7860
python3 launch.py --listen --port 7860

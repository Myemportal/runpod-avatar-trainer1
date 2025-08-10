#!/usr/bin/env python3
import argparse, os, subprocess
parser = argparse.ArgumentParser()
parser.add_argument('--name', required=True)
parser.add_argument('--images', default='/workspace/training/images')
parser.add_argument('--output', default='/workspace/models/lora')
parser.add_argument('--epochs', type=int, default=10)
parser.add_argument('--resolution', type=int, default=512)
args = parser.parse_args()
model_base = os.environ.get('BASE_MODEL', 'runwayml/stable-diffusion-v1-5')
save_dir = os.path.join(args.output, args.name)
os.makedirs(save_dir, exist_ok=True)
train_cmd = [
    'python3', '/workspace/stable-diffusion-webui/extensions/sd-webui-additional-networks/train_network.py',
    '--pretrained_model_name_or_path', model_base,
    '--train_data_dir', args.images,
    '--output_dir', save_dir,
    '--resolution', str(args.resolution),
    '--epochs', str(args.epochs),
    '--network_dim', '8',
    '--save_model_as', 'safetensors'
]
print('Running LoRA train command: ', ' '.join(train_cmd))
subprocess.check_call(train_cmd)
print('LoRA saved to', save_dir)

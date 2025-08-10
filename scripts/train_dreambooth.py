#!/usr/bin/env python3
import argparse, os, subprocess
parser = argparse.ArgumentParser()
parser.add_argument('--name', required=True)
parser.add_argument('--images', default='/workspace/training/images')
parser.add_argument('--output', default='/workspace/models/dreambooth')
parser.add_argument('--steps', type=int, default=2000)
parser.add_argument('--resolution', type=int, default=512)
args = parser.parse_args()
outdir = os.path.join(args.output, args.name)
os.makedirs(outdir, exist_ok=True)
train_cmd = [
  'accelerate', 'launch', '/workspace/stable-diffusion-webui/extensions/dreambooth/train_dreambooth.py',
  '--pretrained_model_name_or_path', os.environ.get('BASE_MODEL', 'runwayml/stable-diffusion-v1-5'),
  '--instance_data_dir', args.images,
  '--output_dir', outdir,
  '--resolution', str(args.resolution),
  '--num_train_steps', str(args.steps)
]
print('Running DreamBooth train command: ', ' '.join(train_cmd))
subprocess.check_call(train_cmd)
print('DreamBooth saved to', outdir)

#!/usr/bin/env python3
from PIL import Image
from transformers import BlipProcessor, BlipForConditionalGeneration
import os
processor = BlipProcessor.from_pretrained('Salesforce/blip-image-captioning-base')
model = BlipForConditionalGeneration.from_pretrained('Salesforce/blip-image-captioning-base')
img_dir = '/workspace/training/images'
out_dir = '/workspace/training/captions'
os.makedirs(out_dir, exist_ok=True)
for fn in os.listdir(img_dir):
    if not fn.lower().endswith(('.png','.jpg','.jpeg')): continue
    p = os.path.join(img_dir, fn)
    img = Image.open(p).convert('RGB')
    inputs = processor(images=img, return_tensors='pt')
    out = model.generate(**inputs)
    caption = processor.decode(out[0], skip_special_tokens=True)
    with open(os.path.join(out_dir, os.path.splitext(fn)[0]+'.txt'),'w') as f:
        f.write(caption)
    print(fn, '->', caption)

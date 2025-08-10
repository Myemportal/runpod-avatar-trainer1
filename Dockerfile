FROM nvidia/cuda:12.1.1-cudnn8-runtime-ubuntu22.04
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y python3-pip git ffmpeg libjpeg-dev build-essential wget curl unzip libsndfile1 \
    && rm -rf /var/lib/apt/lists/*
WORKDIR /workspace
COPY install.sh /workspace/install.sh
COPY run.sh /workspace/run.sh
COPY scripts/ /workspace/scripts/
RUN chmod +x /workspace/install.sh /workspace/run.sh /workspace/scripts/*.py
ENTRYPOINT ["/workspace/run.sh"]

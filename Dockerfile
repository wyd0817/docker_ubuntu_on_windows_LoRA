# Base image file
FROM nvidia/cuda:12.1.0-devel-ubuntu22.04

# Environment setup
ENV LIBRARY_PATH=/usr/local/cuda/lib64/stubs
ENV DISPLAY=host.docker.internal:0.0
ENV PULSE_SERVER=tcp:host.docker.internal:4713
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Tokyo

# Set working directory
WORKDIR /root

# Install required packages
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y \
    python3.10 \
    python3.10-dev \
    python3-pip \
    git \
    wget \
    build-essential \
    cmake \
    ffmpeg && \
    rm -rf /var/lib/apt/lists/*

# Install the latest version of cuDNN
RUN apt-get update && apt-get install -y --no-install-recommends \
    libcudnn8=8.9.3.* libcudnn8-dev=8.9.3.* && \
    rm -rf /var/lib/apt/lists/*

# Set timezone
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install Python packages using conda
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh && \
    bash miniconda.sh -b -p /root/miniconda && \
    rm miniconda.sh

ENV PATH="/root/miniconda/bin:${PATH}"

RUN conda install -y pytorch torchvision torchaudio pytorch-cuda=12.1 -c pytorch -c nvidia && \
    pip3 install transformers accelerate deepspeed peft editdistance Levenshtein tensorboard gradio moviepy submitit && \
    pip3 install flash-attn --no-build-isolation && \
    pip3 install omegaconf vocos vector_quantize_pytorch cython

# Install the latest version of ffmpeg
RUN wget https://johnvansickle.com/ffmpeg/releases/ffmpeg-release-amd64-static.tar.xz && \
    tar xvf ffmpeg-release-amd64-static.tar.xz && \
    rm ffmpeg-release-amd64-static.tar.xz && \
    mv ffmpeg-*-amd64-static ffmpeg && \
    cp ffmpeg/ffmpeg /usr/local/bin/ && \
    cp ffmpeg/ffprobe /usr/local/bin/ && \
    rm -rf ffmpeg

# Clone the VideoLLM-online repository
RUN mkdir -p /root/share && \
    git clone https://github.com/showlab/videollm-online.git /root/share/videollm-online

# Clone the ChatTTS repository
RUN git clone https://github.com/2noise/ChatTTS.git /root/share/videollm-online/demo/rendering/ChatTTS

# Set working directory to the project folder
WORKDIR /root/share/videollm-online

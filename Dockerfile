# ベースイメージファイル
FROM nvidia/cuda:12.2.0-devel-ubuntu22.04

# 環境設定
ENV LIBRARY_PATH=/usr/local/cuda/lib64/stubs
ENV DISPLAY=host.docker.internal:0.0
ENV PULSE_SERVER=tcp:host.docker.internal:4713
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Tokyo

# ワークディレクトリの設定
WORKDIR /root

# Ubuntu上での環境構築
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y \
    python3 \
    python3-pip \
    git \
    build-essential \
    cmake && \
    rm -rf /var/lib/apt/lists/*

# cuDNNのインストール
RUN apt-get update && apt-get install -y --no-install-recommends \
    libcudnn8=8.9.3.* libcudnn8-dev=8.9.3.* && \
    rm -rf /var/lib/apt/lists/*

# タイムゾーンの設定
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Python パッケージのインストール
RUN pip3 install --upgrade pip && \
    pip3 uninstall unsloth -y && \
    pip3 install --upgrade --no-cache-dir "unsloth[colab-new] @ git+https://github.com/unslothai/unsloth.git" && \
    pip3 install --no-deps "trl<0.9.0" peft accelerate bitsandbytes && \
    pip3 install --upgrade torch xformers && \
    pip3 install ipywidgets --upgrade && \
    pip3 install datasets transformers tqdm && \
    pip3 install --no-deps packaging ninja einops "flash-attn>=2.6.3"

# 作業ディレクトリに移動
WORKDIR /root

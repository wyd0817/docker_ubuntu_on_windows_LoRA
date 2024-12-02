# Docker Ubuntu on Windows with LoRA Support

This repository provides a streamlined setup for running an Ubuntu environment on Windows using Docker, with built-in support for Low-Rank Adaptation (LoRA) for AI and machine learning projects.

## Features

- **Ubuntu Environment**: Fully functional Ubuntu system running in Docker on a Windows host.
- **LoRA Support**: Pre-configured environment for running LoRA-based AI models.
- **Efficient Setup**: Simplified scripts and instructions to get you up and running quickly.
- **Cross-Platform Compatibility**: Leverages Docker to ensure consistency across Windows environments.
- **VS Code Integration**: Recommended to use the Docker extension in Visual Studio Code for enhanced development experience.

## Requirements

- Windows 10/11 with [WSL2](https://learn.microsoft.com/en-us/windows/wsl/install) installed.
- [Docker Desktop](https://www.docker.com/products/docker-desktop) with WSL2 backend enabled.
- At least 16GB of RAM (recommended for AI model training and inference).
- NVIDIA GPU with [NVIDIA Container Toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html) installed.
- [Visual Studio Code](https://code.visualstudio.com/) with the [Docker Extension](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-docker).

## Setup Instructions

### Step 1: Clone the Repository

```bash
git clone https://github.com/wyd0817/docker_ubuntu_on_windows_LoRA.git
cd docker_ubuntu_on_windows_LoRA
```

### Step 2: Build the Docker Image

1. Open a terminal in the repository directory.
2. Build the Docker image:

   ```bash
   docker build -t ubuntu_lora:latest .
   ```

### Step 3: Run the Docker Container

Run the container with the following command:

```bash
docker run -it --gpus all --name ubuntu_lora_container ubuntu_lora:latest
```

If you do not have an NVIDIA GPU or wish to run without GPU support:

```bash
docker run -it --name ubuntu_lora_container ubuntu_lora:latest
```

### Step 4: Open the Container in VS Code

1. Install the [Docker Extension](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-docker) in Visual Studio Code.
2. Open VS Code and navigate to the **Docker** panel.
3. Locate the running container (`ubuntu_lora_container`) in the **Containers** list.
4. Right-click the container and select **Attach Shell** to open a terminal directly in VS Code.
5. Alternatively, you can open the container's file system in VS Code for editing files inside the container.

### Step 5: Stop and Restart the Container

To stop the container:

```bash
docker stop ubuntu_lora_container
```

To restart the container:

```bash
docker start -ai ubuntu_lora_container
```

## Pre-installed Packages

- **Python and Pip**: Pre-installed for running AI-related Python scripts.
- **LoRA Libraries**: Key dependencies for training and fine-tuning models using LoRA.
- **CUDA and cuDNN**: (If GPU support is enabled) Pre-installed for leveraging NVIDIA GPUs.

## License

This project is licensed under the [MIT License](LICENSE).
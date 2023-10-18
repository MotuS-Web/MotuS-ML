# Uvicorn Guide

This document contains the process of implementing Python, FastAPI, Uvicorn, Pytorch, etc., directly, without using Docker. For installation using Docker, please refer to the [Docker Guide](./DOCKER.md).

## Requirements.

This code requires a set of essential modules to build an API server using FastAPI, run artificial intelligence processes with torch and torchvision, access databases using mysql_connector, transform and utilize uploaded videos using scikit-video, numpy, and openCV. It also utilizes the request and json modules for fetching files from Naver Cloud Object. Additionally, internal utility modules and methods exist, so `main.py` necessitates `utils.py`, `models.py`, and `connector.py`.

The summarized requirements are as follows:

- torch (>= 2.0.0)
- torchvision (>= 0.15.0)
- numpy (>= 1.23.5)
- skvideo (>= 1.1.11)
- cv2 (>= 4.8.0)
- fastapi (>= 0.100.0)
- polars (>= 0.17.7)
- mariadb (>=)

Please note that the `requirements.txt` hasn't been separately written due to the numerous modules used for personal experimentation and development within the current environment. Your understanding is appreciated.

## Secret Key

We perform the task of accessing the database to compare guide videos and user videos. To perform this task, the `secret_key.json` file is required. The `secret_key.json` file should be structured as follows:

```json
{
    "database": {
        "host": "YOUR_DATABASE_HOST",
        "port": YOUR_DATABASE_PORT_NUMBER,
        "user": "YOUR_DATABASE_USER_NAME",
        "password": "YOUR_DATABASE_USER_PASSWORD",
        "database": "YOUR_DATABASE_NAME"
    }
}
```

The `secret_key.json` file should be written in the above format and should be located outside the `./app` directory. This file is used to access the database through the `connector.py` code. The code is written with Maria Database or MySQL Database as the reference, and if you are interested in supporting other databases, please feel free to submit a Pull Request🤗.

Additionally, for security reasons, this repository does not provide the `secret_key.json` file, so you need to configure it yourself.

## Device Setting
Device configuration allows you to select your desired device from CUDA (Compute Unified Device Architecture), MPS (Metal Performance Shaders), or CPU. Please note that the code is set to use the CPU by default.

```python
# main.py

app = FastAPI()
extractor = SkeletonExtractor(pretrained_bool=True, number_of keypoints=17, device='cuda')
preprocessor = Data Preprocessing()
metrics = Metrics()
```

If you want to change from CPU to CUDA, MPS, or another device, you can choose one of `cuda`, `cpu`, or `mps` as the `device` argument in the `SkeletonExtractor` object. If you want to use `cuda`, **you must have CUDA configured on your device**. For more details, please refer to the [Nvidia CUDA official documentation](https://docs.nvidia.com/cuda/). Using CPU is possible by default as long as PyTorch is installed.

However, for devices like `mps`, there are devices based on ARM architecture, such as Apple's laptop series. In such cases, you need to modify environment variables as follows before proceeding with the [Quick Start](#quick-start):

```bash
export PYTORCH_ENABLE_MPS_FALLBACK=1
```

## Quick Start

To set up the FastAPI server, it's essential to install [Uvicorn](https://www.uvicorn.org/) first. After installation, you can run the server using the following command in the directory containing `main.py`:

```bash
$ uvicorn main:app --host 0.0.0.0 --port 8080
INFO:     Started server process [60991]
INFO:     Waiting for application startup.
INFO:     Application startup complete.
INFO:     Uvicorn running on http://127.0.0.1:8080 (Press CTRL+C to quit)
```

If you plan on making modifications and building the API server iteratively, you can use the following command:

```bash
$ uvicorn main:app --host 0.0.0.0 --port 8080 --reload
INFO:     Will watch for changes in these directories: ['path/to/ReHab-ML']
INFO:     Uvicorn running on http://127.0.0.1:8080 (Press CTRL+C to quit)
INFO:     Started reloader process [61155] using StatReload
INFO:     Started server process [61157]
INFO:     Waiting for application startup.
INFO:     Application startup complete.
```

The `--reload` parameter automatically restarts the server whenever there's a change in the internal code and it's saved. However, if the server is in the process of preparing a response after a request, it might restart after responding, so keep that in mind.

When setting the Host to 0.0.0.0, it will automatically be allocated as a Public IP. We recommend setting it to 0.0.0.0 when deploying, but please be aware that this may vary depending on the installation environment and network configuration.
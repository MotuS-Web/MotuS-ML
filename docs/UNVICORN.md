# Uvicorn Guide

This document contains the process of implementing Python, FastAPI, Uvicorn, Pytorch, etc., directly, without using Docker. For installation using Docker, please refer to the ![Docker Guide](./DOCKER.md).

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

디바이스 세팅은 당신이 CUDA (Compute Unified Device Architecture), MPS (Metal Performance Shaders) 그리고 CPU 중에 원하는 Device를 선택하고 진행하시기 바랍니다. 본 코드는 기본적으로는 CPU로 세팅되어 있음을 알립니다.

```python
# main.py

app = FastAPI()
extractor = SkeletonExtractor(pretrained_bool=True, number_of_keypoints=17, device='cuda')
preprocessor = DataPreprocessing()
metrics = Metrics()
```

CPU가 아닌 CUDA, MPS 등으로 변경을 원한다면 `SkeletonExtractor` 객체의 Argument인 device를 `cuda`, `cpu`, `mps` 중 하나를 선택하시면 됩니다. `cuda`를 원하시는 경우에는 **반드시 Device에 CUDA설정이 되어 있어야합니다.** 자세한 내용은 ![Nvidia CUDA 공식 Document](https://docs.nvidia.com/cuda/) 참고하시기 바랍니다. cpu는 기본적으로 pytorch가 설치가 된다면 진행할 수 있습니다. 

다만, `mps` 같은 경우에는 Apple의 노트북 시리즈 중 ARM 아키텍쳐 기반으로 탑재된 디바이스가 있습니다. 이와 같은 경우에는 [Quick Start](#quick-start) 전에 미리 아래와 같이 환경변수를 변경해야합니다.

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
# Docker Guide

This document covers building the MotuS AI API server in a Docker container using Docker image files. If you prefer to work with Python, FastAPI, Uvicorn, Pytorch, etc., directly and want to install them, please refer to the [Uvicorn Guide](./UNVICORN.md).

## Requirements

First and foremost, you need an environment on your device where you can install Docker. For information on Docker installation, please refer to the official documentation, ["Install Docker Engine"](https://docs.docker.com/engine/install/).

You also need adequate hardware performance. The code has been developed on M1 Chipset and Nvidia 2070, and deployment is carried out on the Nvidia Jetson Nano Board. While GPU usage is recommended, be aware that the Docker image may differ if you choose to use a CPU or MPS (Metal Performance Shaders) instead.

| Device               | Tested | Description                |
|----------------------|--------|----------------------------|
| GPU (CUDA)           | ✅     | 9TFLOPs or higher, vRAM 8GB or higher |
| CPU                  | ❌     | __NOT TESTED__ |
| MPS (Metal Performance Shaders) | ✅ | M1 or higher supported |

## Let's Get Started!

You can pull this Docker image from Docker Hub. You can find the Docker Hub link [here](https://hub.docker.com/r/cherryboomincake/motus_ml). If you've verified the required hardware and software compatibility, you can download the Docker image using the following command:

```bash
$ docker pull cherryboomincake/motus_ml
Using the default tag: latest
latest: Pulling from cherryboomincake/motus_ml
...
Status: Downloaded newer image for cherryboomincake/motus_ml:latest
docker.io/cherryboomincake/motus_ml:latest
```

If the pull is successful, you will see the output without any errors.

Before turning the `motus_ml` image into a container, you need to create the `secret_key.json` file. We perform the task of accessing the database to compare guide videos and user videos. To perform this task, the `secret_key.json` file is required. The `secret_key.json` file should be structured as follows:

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
Next, this is how to create and run a Docker container. Assuming you've created the `secret_key.json` mentioned above, you can execute the following command:

```bash
docker run -p 8000:8000 --mount type=bind,source=<YOUR PATH>/secret_key.json,target=/app/secret_key.json motus_ml:latest
/usr/local/lib/python3.10/site-packages/torchvision/models/_utils.py:208: UserWarning: The parameter 'pretrained' is deprecated since 0.13 and may be removed in the future, please use 'weights' instead.
  warnings.warn(
...
INFO:     Uvicorn running on http://0.0.0.0:8000 (Press CTRL+C to quit)
```

An important point here is the content of the `source` argument. In the example command, it is written as `source=<YOUR_PATH>/secret_key.json`. You need to specify the location of the `secret_key.json` file.

During the initial run, it may take some time to download the model. Afterward, if the container is created and running without significant issues, you will see the `Uvicorn running` message as shown above. If you have any troubleshooting or other requests, please leave a Github issue 🤗.
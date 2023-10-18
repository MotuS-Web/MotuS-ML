# Docker Guide

본 문서에서는 Docker image 파일을 통해서 Docker container로 MotuS AI API 서버 구축을 다룹니다. 만일 Python, FastAPI, Uvicorn, Pytorch 등에 대해 직접 다루고 설치를 원한다면 ![Uvicorn Guide](./UNVICORN.md)를 참고하시기 바랍니다.

## Requirments

우선적으로 실행하고자 하는 Device에 Docker를 설치할 수 있는 환경이 있어야합니다. Docker 설치에 관해서는 공식 문서인 ["Install Docker Engine"](https://docs.docker.com/engine/install/) 를 참고하시기 바랍니다. 

Hardware 성능도 필요로 합니다. 본 코드들은 M1 Chipset과 Nvidia 2070에서 개발이 되었으며 배포는 Nvidia Jetson Nano Board에서 이루어지고 있습니다. GPU 사용을 권장드리고 있지만, GPU가 아닌 CPU 또는 MPS를 사용하실 경우에는 Image가 각기 다를 것이니 참고하시기 바랍니다. 

|Device|Tested|Describition|
|------|------|------------|
|GPU(CUDA)|✅|9TFLOPs 이상, vRAM 8GB 이상|
|CPU|❌|__NOT TESTED__|
|MPS(Metal Performance Shaders)|✅|M1 이상 가능|
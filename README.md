<div align="center">

  <img src="https://github.com/MotuS-Web/MotuS-Backend/assets/80760160/dea1f252-ec63-410f-8516-fc4adcfd1393" alt="motus_logo" width="300" height="300">

MotuS Artifical Intelligence, for measuring your move.

</div>

# ReHab Machine Learning - Pose Estimation

This repository is the artificial intelligence repository for the ReHab project. Artificial intelligence is a crucial element in the project, as it provides essential services and methods for guiding users in performing exercises. Through artificial intelligence, we offer guidance videos and provide users with a way to perform exercises. We evaluate how well the user is doing by measuring similarity through feature extraction and cosine similarity using the videos provided by the user.

We utilize pre-trained models for our system. The baseline model employs Posenet, and this choice might change based on considerations such as the trade-off between communication overhead and computation overhead.

## Requirements

We provide two installation methods. The first method is to run the code directly, as described in the document. The second method is to obtain the Docker image and run it through Docker. Please read the documentation for the installation method you prefer and proceed accordingly.

- [Docker Guide](./docs/DOCKER.md)
- [Uvicorn Guide](./docs/UNVICORN.md)

This code requires a set of essential modules to build an API server using FastAPI, run artificial intelligence processes with torch and torchvision, access databases using mysql_connector, transform and utilize uploaded videos using scikit-video, numpy, and openCV. It also utilizes the request and json modules for fetching files from Naver Cloud Object. Additionally, internal utility modules and methods exist, so `main.py` necessitates `utils.py`, `models.py`, and `connector.py`.

The summarized requirements are as follows:

- torch (>= 2.0.0)
- torchvision (>= 0.15.0)
- numpy (>= 1.23.5)
- skvideo (>= 1.1.11)
- cv2 (>= 4.8.0)
- fastapi (>= 0.100.0)
- polars (>= 0.17.7)
- mysql.connector (>= 8.1.0)

Please note that the `requirements.txt` hasn't been separately written due to the numerous modules used for personal experimentation and development within the current environment. Your understanding is appreciated.

## Our Model

The `torchvision.models` module in PyTorch provides various pre-trained and state-of-the-art model architectures. Since extracting human poses from images is crucial, we have used the Keypoint RCNN ResNet50 FPN-based model, which is capable of extracting keypoints. Understanding it as a structure comprising Keypoint R-CNN + ResNet50 FPN makes it easier to comprehend.

As mentioned in the [official documentation](https://pytorch.org/vision/stable/models/generated/torchvision.models.detection.keypointrcnn_resnet50_fpn.html#torchvision.models.detection.keypointrcnn_resnet50_fpn), the default weights are from a model trained on the COCO Dataset v1. This model has more parameters compared to legacy models, though GFLOPs are reduced, resulting in an improved performance model.

FROM python:3.10.9

WORKDIR /app

COPY requirements.txt /app/requirements.txt

RUN pip install --no-cache-dir --upgrade pip
RUN pip install --no-cache-dir --upgrade -r requirements.txt

COPY . /app
COPY .dockerignore .
COPY . .

RUN apt-get update && apt-get install ffmpeg libsm6 libxext6  -y

ENV SECRET_KEY_FILE=/run/secrets/secret_key.json

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000", "--log-level", "trace", "--ssl-keyfile", "./app/keys/private.key", "--ssl-certfile", "./app/keys/certificate.crt"]
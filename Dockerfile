# For more information, please refer to https://aka.ms/vscode-docker-python
FROM python:3.8-slim

ARG APCA_API_KEY_ID
ENV APCA_API_KEY_ID=$APCA_API_KEY_ID
ARG APCA_API_SECRET_KEY
ENV APCA_API_SECRET_KEY=$APCA_API_SECRET_KEY

RUN pip3 install alpaca-py

RUN adduser -u 1000 someone --home /app

RUN mkdir -p /app
COPY ./main.py /app

USER someone
WORKDIR /app

CMD ["python3", "-u", "main.py"]

FROM python:3.12-bullseye
LABEL org.opencontainers.image.authors="cccuroky@gmail.com"

RUN apt-get update -y \
  && apt-get install -y gcc g++ \
  && pip install pipx

COPY install-pkgs.sh .
RUN ./install-pkgs.sh

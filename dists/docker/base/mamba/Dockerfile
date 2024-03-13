FROM curoky/dotbox:nixpkg
LABEL org.opencontainers.image.authors="cccuroky@gmail.com"

COPY env env
COPY install.sh .

RUN sudo mkdir -p /o/conda && sudo chown 1000:1000 -R /o \
  && curl -sSL -o /tmp/miniforge3.sh https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-x86_64.sh \
  && bash /tmp/miniforge3.sh -b -u -p /o/conda \
  && ./install.sh ./env

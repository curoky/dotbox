FROM curoky/dotbox:nixpkg
LABEL org.opencontainers.image.authors="cccuroky@gmail.com"

COPY env env
COPY install-pkgs.sh .

RUN curl -sSL -o /tmp/miniforge3.sh https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-x86_64.sh \
  && bash /tmp/miniforge3.sh -b -u -p /o/conda \
  && ./install-pkgs.sh ./env

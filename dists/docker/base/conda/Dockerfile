FROM curoky/dotbox:stage_nixpkg
LABEL org.opencontainers.image.authors="cccuroky@gmail.com"

COPY env env
COPY install-pkgs.sh .

RUN curl -sSL -o /tmp/miniconda.sh https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
  && bash /tmp/miniconda.sh -b -u -p /app/conda \
  && ./install-pkgs.sh ./env

FROM curoky/dotbox:stage_nixpkg
LABEL org.opencontainers.image.authors="cccuroky@gmail.com"

COPY env env
COPY setup-conda-env.sh .

RUN curl -sSL -o /tmp/miniconda.sh https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
  && bash /tmp/miniconda.sh -b -u -p /app/conda \
  && ./setup-conda-env.sh env/py2.yaml \
  && ./setup-conda-env.sh env/py3.yaml \
  && ./setup-conda-env.sh env/tf1.15.yaml 1 \
  && ./setup-conda-env.sh env/tf2.11.yaml 1 \
  && ./setup-conda-env.sh env/tf2.16.yaml 1 \
  && rm -rf /tmp/*

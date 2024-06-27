FROM debian:bullseye-backports
LABEL org.opencontainers.image.authors="cccuroky@gmail.com"

RUN apt-get update -y \
  && apt-get install -y curl gcc g++ git

COPY env env
COPY setup-conda-env.sh .

RUN curl -sSL -o /tmp/miniconda.sh https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
  && bash /tmp/miniconda.sh -b -u -p /app/conda \
  && ./setup-conda-env.sh env/py2.yaml \
  && ./setup-conda-env.sh env/py3.yaml \
  && ./setup-conda-env.sh env/tf1.15.yaml 1 \
  && ./setup-conda-env.sh env/tf2.5.yaml 1 11.4 \
  && ./setup-conda-env.sh env/tf2.11.yaml 1 \
  && ./setup-conda-env.sh env/tf2.16.yaml 1 12.5 \
  && rm -rf /tmp/*

COPY --from=pipx install-pkgs.sh install-pipx-pkgs.sh
ENV PATH=${PATH}:/app/conda/bin
RUN pip install pipx \
  && ./install-pipx-pkgs.sh

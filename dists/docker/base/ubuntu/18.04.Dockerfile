FROM ubuntu:18.04

RUN apt-get update \
  && apt-get remove --allow-remove-essential -y curl grep gzip findutils util-linux procps \
    ncurses-bin ncurses-base \
  && apt-get install -y --no-install-recommends \
    sudo systemd \
  && apt-get autoremove -y \
  && echo "root:123456" | chpasswd

FROM ubuntu:18.04

RUN apt-get update \
  && apt-get remove --allow-remove-essential -y curl grep sed gzip bash findutils util-linux procps perl-base \
    ncurses-bin ncurses-base libncursesw6 libtinfo6 \
  && apt-get install -y --no-install-recommends \
    sudo systemd \
  && apt-get autoremove -y \
  && echo "root:123456" | chpasswd

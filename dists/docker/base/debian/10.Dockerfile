FROM debian:buster-backports

RUN apt-get update \
  && apt-get remove --allow-remove-essential -y curl grep sed gzip bash findutils procps \
    ncurses-bin ncurses-base libncursesw6 libtinfo6 \
  && apt-get install -y --no-install-recommends \
    sudo systemd \
  && apt-get autoremove -y \
  && echo "root:123456" | chpasswd

FROM ubuntu:23.10

RUN apt-get update \
  && apt-get remove --allow-remove-essential -y curl grep sed gzip findutils util-linux procps \
    ncurses-bin ncurses-base libncursesw6 \
  && apt-get install -y --no-install-recommends \
    sudo systemd \
    # xfce4 xfce4-goodies tightvncserver
  && apt-get autoremove -y \
  && userdel ubuntu -r \
  && echo "root:123456" | chpasswd

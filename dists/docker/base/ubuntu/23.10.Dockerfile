FROM ubuntu:23.10

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    sudo systemd \
    # xfce4 xfce4-goodies tightvncserver
  && apt-get remove --allow-remove-essential -y curl grep sed gzip bash findutils util-linux procps perl-base \
    ncurses-bin ncurses-base libncursesw6 libtinfo6 \
  && apt-get autoremove -y \
  && userdel ubuntu -r \
  && echo "root:123456" | chpasswd

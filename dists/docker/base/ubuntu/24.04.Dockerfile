FROM ubuntu:24.04

RUN apt-get update \
  && apt-get remove --allow-remove-essential -y curl grep sed gzip bash findutils util-linux procps perl-base \
    ncurses-bin ncurses-base libncursesw6 libtinfo6 \
  && apt-get install -y --no-install-recommends \
    sudo systemd \
  && apt-get autoremove -y \
  # update user
  && userdel ubuntu -r \
  && echo "root:123456" | chpasswd \
  && useradd --create-home --shell /nix/var/nix/profiles/default/bin/zsh --uid 1000 --user-group cicada \
  && echo "cicada:123456" | chpasswd \
  && usermod -aG sudo cicada \
  && echo "cicada ALL=(ALL:ALL) NOPASSWD:ALL" >>/etc/sudoers.d/nopasswd_user

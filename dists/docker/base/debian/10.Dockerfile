FROM debian:buster-backports

RUN sed -i 's/deb.debian.org/archive.debian.org/g' /etc/apt/sources.list \
  && sed -i '/debian stretch-updates/d' /etc/apt/sources.list \
  && sed -i 's|archive.debian.org/debian-security|security.debian.org|g' /etc/apt/sources.list \
  && sed -i 's/deb.debian.org/archive.debian.org/g' /etc/apt/sources.list.d/backports.list \
  && apt-get update \
  && apt-get remove --allow-remove-essential -y curl grep sed gzip findutils procps \
    ncurses-bin ncurses-base libncursesw6 libtinfo6 \
    iproute2 iputils-ping tzdata \
  && apt-get install -y --no-install-recommends \
    sudo systemd \
  && apt-get autoremove -y \
  # update user
  && echo "root:123456" | chpasswd \
  && useradd --create-home --shell /nix/var/nix/profiles/default/bin/zsh --uid 1000 --user-group x \
  && echo "x:123456" | chpasswd \
  && usermod -aG sudo x \
  && echo "x ALL=(ALL:ALL) NOPASSWD:ALL" >>/etc/sudoers.d/nopasswd_user

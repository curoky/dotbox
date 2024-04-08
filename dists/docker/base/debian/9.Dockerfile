FROM debian:stretch-backports

RUN sed -i 's/deb.debian.org/archive.debian.org/g' /etc/apt/sources.list \
  && sed -i '/debian stretch-updates/d' /etc/apt/sources.list \
  && sed -i 's/security.debian.org/archive.debian.org/g' /etc/apt/sources.list \
  && sed -i 's/deb.debian.org/archive.debian.org/g' /etc/apt/sources.list.d/backports.list \
  && apt-get update \
  && apt-get install -y --no-install-recommends \
    sudo systemd init rsyslog gcc g++ \
  && apt-get autoremove -y
  # update user
  && echo "root:123456" | chpasswd \
  && useradd --create-home --shell /nix/var/nix/profiles/default/bin/zsh --uid 1000 --gid 1000 --user-group cicada \
  && echo "cicada:123456" | chpasswd \
  && usermod -aG sudo cicada \
  && echo "cicada ALL=(ALL:ALL) NOPASSWD:ALL" >>/etc/sudoers.d/nopasswd_user

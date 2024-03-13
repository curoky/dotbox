FROM debian:stretch-backports
RUN sed -i 's/deb.debian.org/archive.debian.org/g' /etc/apt/sources.list \
  && sed -i '/debian stretch-updates/d' /etc/apt/sources.list \
  && sed -i 's/security.debian.org/archive.debian.org/g' /etc/apt/sources.list \
  && sed -i 's/deb.debian.org/archive.debian.org/g' /etc/apt/sources.list.d/backports.list \
  && apt-get update \
  && apt-get install -y --no-install-recommends \
    sudo systemd init rsyslog gcc g++ \
  && apt-get autoremove -y

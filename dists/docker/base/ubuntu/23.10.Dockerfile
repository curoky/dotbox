FROM ubuntu:23.10 as base_ubuntu23.10
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    sudo systemd init rsyslog \
    # xfce4 xfce4-goodies tightvncserver
  # && apt-get remove --allow-remove-essential -y perl-base \
  && apt-get remove --allow-remove-essential -y curl grep sed gzip bash findutils \
  && apt-get autoremove -y

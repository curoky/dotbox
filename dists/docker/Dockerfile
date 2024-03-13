# syntax=docker/dockerfile:1.4
ARG BASE_IMAGE=

FROM ubuntu:23.10 as base_ubuntu23.10
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    sudo systemd init rsyslog \
    # xfce4 xfce4-goodies tightvncserver
  # && apt-get remove --allow-remove-essential -y perl-base \
  && apt-get remove --allow-remove-essential -y curl grep sed gzip bash findutils \
  && apt-get autoremove -y

FROM base_${BASE_IMAGE}
LABEL org.opencontainers.image.authors="cccuroky@gmail.com"

ENV PATH=$PATH:/nix/var/nix/profiles/default/bin:/nix/var/nix/profiles/gcc13/bin \
  DEBIAN_FRONTEND=noninteractive

COPY --link --chown=1000:1000 --from=curoky/dotbox:nixpkg /nix /nix
# COPY --link --chown=1000:1000 --from=curoky/dotbox:mamba /o/conda /o/conda
COPY --chown=1000:1000 ./ /o/dotbox

RUN /o/dotbox/images/script/setup-sys-user.sh \
  && /o/dotbox/images/script/setup-sys-backport-pkg.sh \
  && dotdrop install --cfg=/o/dotbox/config.yaml --force --profile=devbox-sysconf \
  && dotdrop install --cfg=/o/dotbox/config.yaml --force --profile=devbox-userconf-outofbox \
  && mkdir -p /data/share /data/cache /data/workspace \
  && chown cicada:cicada /data/share /data/cache /data/workspace /opt /home/cicada

USER cicada
RUN curl -L https://nixos.org/nix/install | sh -s -- --no-daemon \
  && dotdrop install --cfg=/o/dotbox/config.yaml --force --profile=devbox-userconf-base

USER root
ENTRYPOINT ["/o/dotbox/images/script/entrypoint.sh"]

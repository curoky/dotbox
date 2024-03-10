# syntax=docker/dockerfile:1.4
ARG BASE_IMAGE=

FROM debian:stretch-backports as base_debian9
RUN sed -i 's/deb.debian.org/archive.debian.org/g' /etc/apt/sources.list \
  && sed -i '/debian stretch-updates/d' /etc/apt/sources.list \
  && sed -i 's/security.debian.org/archive.debian.org/g' /etc/apt/sources.list \
  && sed -i 's/deb.debian.org/archive.debian.org/g' /etc/apt/sources.list.d/backports.list \
  && apt-get update \
  && apt-get install -y --no-install-recommends \
    curl gnupg2 ca-certificates locales tzdata sudo init systemd \
    openssh-server rsyslog gcc g++ \
  && apt-get autoremove -y

FROM ubuntu:23.10 as base_ubuntu23.10
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    systemd init sudo openssh-server rsyslog \
    # xfce4 xfce4-goodies tightvncserver
  && apt-get autoremove -y

FROM base_${BASE_IMAGE}
LABEL org.opencontainers.image.authors="cccuroky@gmail.com"

ENV PATH=$PATH:/nix/var/nix/profiles/default/bin \
  DEBIAN_FRONTEND=noninteractive \
  LANG=en_US.UTF-8 \
  LANGUAGE=en_US.UTF-8 \
  LC_ALL=en_US.UTF-8 \
  LOCALE_ARCHIVE=/usr/lib/locale/locale-archive

# Note: g=u doesn't really work. https://github.com/moby/buildkit/issues/1951
# COPY --chown=1000:1000 --chmod=g=u --from=vcpkg /opt/vcpkg /opt/vcpkg
COPY --link --chown=1000:1000 --from=curoky/dotbox-data /nix /nix
COPY --link --chown=1000:1000 --from=curoky/dotbox-data /o/conda /o/conda
COPY --chown=1000:1000 ./ /o/dotbox

RUN /o/dotbox/images/script/setup-sys-user.sh \
  # && /o/dotbox/images/script/setup-sys-locale.sh \
  && /o/dotbox/images/script/setup-sys-backport-pkg.sh \
  && dotdrop install --cfg=/o/dotbox/config.yaml --force --profile=devbox-sysconf \
  && dotdrop install --cfg=/o/dotbox/config.yaml --force --profile=devbox-userconf-outofbox \
  && chmod +600 /root/.ssh/config \
  && mkdir -p /data/share /data/cache /data/workspace \
  && chown cicada:cicada /data/share /data/cache /data/workspace /opt /home/cicada

USER cicada
RUN curl -L https://nixos.org/nix/install | sh -s -- --no-daemon \
  && dotdrop install --cfg=/o/dotbox/config.yaml --force --profile=devbox-userconf-base

USER root
ENTRYPOINT ["/o/dotbox/images/script/entrypoint.sh"]

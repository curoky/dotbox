FROM homebrew/brew:latest as homebrew
COPY images/script/setup-pkg-brew.sh setup-pkg-brew.sh
COPY Formula/ /home/linuxbrew/.linuxbrew/Homebrew/Library/Taps/curoky/homebrew-dotbox/Formula/
COPY images/config/brew/Brewfile.linux Brewfile.linux
ENV HOMEBREW_NO_ANALYTICS=1
RUN ./setup-pkg-brew.sh Brewfile.linux \
  && rm -rf "$(brew --cache)"

FROM ghcr.io/conda/conda-ci:main-linux-python3.12 as conda
USER root
COPY images/config/pip/*.txt .
COPY images/script/setup-pkg-py.sh .
RUN apt-get -y update && apt-get install -y procps libsnappy-dev \
  && ./setup-pkg-py.sh .

FROM ghcr.io/conda/conda-ci:main-linux-python3.12 as pipx
USER root
COPY images/script/setup-pkg-pipx.sh .
RUN pip3 install pipx \
  && ./setup-pkg-pipx.sh .

FROM ubuntu:latest as vcpkg
RUN apt-get update -qq \
  && apt-get install -y -qq --no-install-recommends \
    ca-certificates git curl zip unzip tar \
  && git clone https://github.com/microsoft/vcpkg /opt/vcpkg \
  && cd /opt/vcpkg \
  && ./bootstrap-vcpkg.sh -disableMetrics

FROM golang:latest as golang
COPY images/config/go/requirements.txt requirements.txt
COPY images/script/setup-pkg-go.sh setup-pkg-go.sh
RUN ./setup-pkg-go.sh requirements.txt

FROM nixos/nix as nixpkgs
ENV NIXPKGS_ALLOW_UNFREE=1 \
  NIXPKGS_ALLOW_BROKEN=1
COPY pkgs/nix pkgs/nix
COPY default.nix default.nix
COPY images/script/setup-pkg-nix.sh setup-pkg-nix.sh
RUN nix-channel --update \
  && ./setup-pkg-nix.sh

FROM ubuntu:23.10
LABEL org.opencontainers.image.authors="cccuroky@gmail.com"

ENV PATH=$PATH:/nix/var/nix/profiles/default/bin:/home/linuxbrew/.linuxbrew/bin:/opt/pipx/bin \
  DEBIAN_FRONTEND=noninteractive \
  # NIX_SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt
  LANG=en_US.UTF-8 \
  LANGUAGE=en_US.UTF-8 \
  LC_ALL=en_US.UTF-8 \
  LOCALE_ARCHIVE=/usr/lib/locale/locale-archive

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    curl gnupg2 ca-certificates locales tzdata sudo init systemd \
    openssh-server rsyslog cron lsb-release \
    # gcc-8 g++-8
    gcc-9 g++-9 perl libxml2 \
    # libsnappy-dev libexpat1 \
    # xfce4 xfce4-goodies tightvncserver
  && apt-get autoremove -y \
  && locale-gen en_US.UTF-8

COPY images/script/setup-sys-*.sh /tmp/

RUN /tmp/setup-sys-locale.sh \
  && /tmp/setup-sys-user.sh \
  && /tmp/setup-sys-timezone.sh \
  && /tmp/setup-sys-backport-pkg.sh \
  && /tmp/setup-sys-update-gcc-version.sh \
  && /tmp/setup-sys-cuda.sh \
  && /tmp/setup-sys-nv-ns.sh

# Note: g=u doesn't really work. https://github.com/moby/buildkit/issues/1951
# COPY --chown=1000:1000 --chmod=g=u --from=vcpkg /opt/vcpkg /opt/vcpkg
COPY --chown=1000:1000 --chmod=g=u --from=homebrew /home/linuxbrew /home/linuxbrew
COPY --chown=1000:1000 --chmod=g=u --from=golang /root/go/bin /home/cicada/go/bin
COPY --chown=1000:1000 --chmod=g=u --from=conda /opt/conda /opt/conda
COPY --chown=1000:1000 --chmod=g=u --from=nixpkgs /nix /nix
COPY --chown=1000:1000 --chmod=g=u --from=pipx /opt/pipx /opt/pipx
COPY --chown=1000:1000 --chmod=g=u ./ /opt/dotbox
COPY --chown=1000:1000 --chmod=g=u ./ /home/cicada/dotbox
COPY --chown=root:adm --chmod=g=u ./ /root/dotbox

RUN /opt/dotbox/images/script/setup-bazel-registry.sh \
  && dotdrop install --cfg=~/dotbox/config.yaml --force --profile=devbox-sysconf \
  && dotdrop install --cfg=~/dotbox/config.yaml --force --profile=devbox-userconf-outofbox \
  && ln -s /nix/var/nix/profiles/default/bin/bazelisk /nix/var/nix/profiles/default/bin/bazel \
  && mkdir /data /data_shared \
  && chown cicada:cicada /data /data_shared /opt

USER cicada

RUN git -C ~/dotbox remote set-url origin git@github.com:curoky/dotbox \
  && dotdrop install --cfg=~/dotbox/config.yaml --force --profile=devbox-userconf-base \
  && curl -L https://nixos.org/nix/install | sh -s -- --no-daemon \
  && /opt/dotbox/images/script/setup-pkg-pipx.sh

USER root
ENTRYPOINT ["/opt/dotbox/images/script/entrypoint.sh"]

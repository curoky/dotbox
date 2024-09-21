# syntax=docker/dockerfile:1.9.0
FROM nixpkgs/nix-unstable:latest AS nixpkgs-builder

# ENV NIX_PATH=nixpkgs=channel:nixpkgs-unstable

RUN nix-channel --add https://github.com/NixOS/nixpkgs/archive/staging.tar.gz staging \
  && nix-channel --update

RUN nix-env -p /nix/var/nix/profiles/default -iA staging.pkgsStatic.perl
RUN nix-env -p /nix/var/nix/profiles/default -iA staging.pkgsStatic.autoconf
RUN nix-env -p /nix/var/nix/profiles/default -iA staging.pkgsStatic.automake
RUN nix-env -p /nix/var/nix/profiles/default -iA staging.pkgsStatic.pkg-config
RUN nix-env -p /nix/var/nix/profiles/default -iA staging.pkgsStatic.libtool
# RUN nix-env -p /nix/var/ntix/profiles/default -iA staging.pkgsStatic.cloc
# RUN nix-env -p /nix/var/nix/profiles/extra -iA nixpkgs.pkgsStatic.pkg-config-unwrapped

FROM debian:bookworm-backports AS packer

COPY --from=nixpkgs-builder /nix /nix
RUN apt-get update -y && apt-get install -y curl python3 python3-pip

COPY pack.py .
RUN mkdir /output \
  && ./pack.py

FROM debian:bookworm-backports
COPY --from=packer /output /output

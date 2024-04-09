FROM ubuntu:23.10
LABEL org.opencontainers.image.authors="cccuroky@gmail.com"

RUN apt-get update -y \
  && apt-get install -y curl xz-utils sudo

RUN userdel ubuntu && rm -rf /home/ubuntu \
  && groupadd -g 1000 -o nix \
  && useradd -m -u 1000 -g 1000 nix \
  && usermod -aG sudo nix \
  && echo "nix ALL=(ALL:ALL) NOPASSWD:ALL" >>/etc/sudoers.d/nopasswd_user

USER nix

ENV PATH=$PATH:/nix/var/nix/profiles/default/bin:/home/nix/.nix-profile/bin:/nix/var/nix/profiles/gcc13/bin \
  NIXPKGS_ALLOW_UNFREE=1 \
  NIXPKGS_ALLOW_BROKEN=1

RUN sudo mkdir -m 0755 /nix && sudo chown nix:nix /nix
RUN curl -L https://nixos.org/nix/install | sh -s -- --no-daemon

COPY --from=nixpkg pkgs pkgs
COPY --from=nixpkg default.nix .
COPY install-pkgs.sh .
RUN nix-channel --update && ./install-pkgs.sh
RUN sudo mkdir -p /app && sudo chown 1000:1000 -R /app

FROM nixos/nix as nixpkgs
ENV NIXPKGS_ALLOW_UNFREE=1 \
  NIXPKGS_ALLOW_BROKEN=1

COPY pkgs/nix pkgs/nix
COPY default.nix .
COPY install.sh .

RUN nix-channel --update
RUN ./install.sh

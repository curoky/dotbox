# This file describes your repository contents.
# It should return a set of nix derivations
# and optionally the special attributes `lib`, `modules` and `overlays`.
# It should NOT import <nixpkgs>. Instead, you should take pkgs as an argument.
# Having pkgs default to <nixpkgs> is fine though, and it lets you use short
# commands such as:
#     nix-build -A mypackage

{ pkgs ? import <nixpkgs> { } }:

{
  protobuf_3_8_0 = pkgs.callPackage ./pkgs/nix/protobuf/3.8.0.nix { };
  protobuf_3_9_2 = pkgs.callPackage ./pkgs/nix/protobuf/3.9.2.nix { };
  zsh-bundle = pkgs.callPackage ./pkgs/nix/zsh-bundle/default.nix { };
  vim-bundle = pkgs.callPackage ./pkgs/nix/vim-bundle/default.nix { };

  dotdrop = pkgs.python3Packages.callPackage ./pkgs/nix/dotdrop/default.nix { };
  licenseheaders = pkgs.python3Packages.callPackage ./pkgs/nix/licenseheaders/default.nix { };
  conan = pkgs.python3Packages.callPackage ./pkgs/nix/conan/default.nix { };

  libxml2_dev = pkgs.libxml2.override {
    enableShared = true;
    enableStatic = false;
  };
}

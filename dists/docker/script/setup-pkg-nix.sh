#!/usr/bin/env bash
# Copyright (c) 2018-2023 curoky(cccuroky@gmail.com).
#
# This file is part of dotbox.
# See https://github.com/curoky/dotbox for further info.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -xeuo pipefail

export PATH=/nix/var/nix/profiles/default/bin:$PATH

# brew bundle list --file /opt/dotbox/config/brew/Brewfile.linux | xargs -n 15
# brew bundle list --file /opt/dotbox/config/brew/Brewfile.linux | awk '{print "nixpkgs."$0}' | xargs -n 5 | awk '{print $0" \ \"}'

# The following packages are not working properly with nix.
#  nixpkgs.conan nixpkgs.bazel_5

pkg_list=(
  # build tools
  nixpkgs.automake nixpkgs.autoconf nixpkgs.libtool nixpkgs.pkg-config nixpkgs.gnumake
  nixpkgs.cmake nixpkgs.ninja nixpkgs.distcc nixpkgs.bazelisk nixpkgs.ccache nixpkgs.mold
  nixpkgs.yarn nixpkgs.pipenv nixpkgs.gradle nixpkgs.maven nixpkgs.nodejs
  nixpkgs.clang-tools_15 nixpkgs.lld_15 nixpkgs.go_1_20 nixpkgs.ruby
  # nixpkgs.lua nixpkgs.vlang nixpkgs.rustup nixpkgs.buck nixpkgs.scons nixpkgs.meson nixpkgs.ant
  # nixpkgs.include-what-you-use
  # nixpkgs.poetry formatter and linter
  nixpkgs.pre-commit nixpkgs.nodePackages.prettier nixpkgs.yapf nixpkgs.nixpkgs-fmt
  nixpkgs.shfmt nixpkgs.buildifier nixpkgs.nodePackages.eslint # nixpkgs.cppcheck
  nixpkgs.cmake-format nixpkgs.shellcheck
  # git
  nixpkgs.git nixpkgs.git-absorb nixpkgs.git-extras nixpkgs.git-lfs nixpkgs.git-filter-repo
  # nixpkgs.lazygit
  # compress
  nixpkgs.bzip2 nixpkgs.xz nixpkgs.zstd nixpkgs.zip nixpkgs.unzip
  # sre
  nixpkgs.iproute2 nixpkgs.iputils nixpkgs.netcat nixpkgs.lsof nixpkgs.connect
  nixpkgs.procps nixpkgs.nettools nixpkgs.fd nixpkgs.ethtool nixpkgs.tcpdump nixpkgs.gdb
  nixpkgs.dstat nixpkgs.rsync nixpkgs.file nixpkgs.gperf nixpkgs.man
  nixpkgs.curl nixpkgs.wget nixpkgs.aria2 nixpkgs.croc nixpkgs.sudo nixpkgs.iptables
  nixpkgs.gnupg nixpkgs.tzdata nixpkgs.unixtools.xxd nixpkgs.locale
  # nixpkgs.gost nixpkgs.htop nixpkgs.cron
  # doc
  nixpkgs.pandoc # nixpkgs.mkdocs nixpkgs.sphinx nixpkgs.hugo
  # shell
  nixpkgs.zsh nixpkgs.bash
  nixpkgs.starship nixpkgs.direnv nixpkgs.tmux # nixpkgs.tmuxinator
  # editor
  nixpkgs.flex nixpkgs.bison nixpkgs.gnupatch nixpkgs.gettext nixpkgs.m4 # nixpkgs.helix
  nixpkgs.jq nixpkgs.vim nixpkgs.bat nixpkgs.less
  # tools
  nixpkgs.graphviz nixpkgs.asciinema nixpkgs.gdu nixpkgs.ncdu nixpkgs.silver-searcher nixpkgs.parallel
  nixpkgs.exa nixpkgs.fzf nixpkgs.cloc nixpkgs.go-task nixpkgs.krb5 nixpkgs.ansible nixpkgs.earthly
  # nixpkgs.jemalloc nixpkgs.flamegraph nixpkgs.dolt nixpkgs.watchman nixpkgs.opencc
  # nixpkgs.atuin nixpkgs.nnn nixpkgs.ranger nixpkgs.lcov nixpkgs.gcovr nixpkgs.navi nixpkgs.ghq
  # nixpkgs.sqlcipher nixpkgs.sqlite nixpkgs.zoxide nixpkgs.wishlist

)
nix-env -p /nix/var/nix/profiles/default -iA "${pkg_list[@]}"

# nix-env -iA -p /nix/var/nix/profiles/gcc49 nixpkgs.gcc49
# nix-env -iA -p /nix/var/nix/profiles/gcc12 nixpkgs.gcc12
# nix-env -iA -p /nix/var/nix/profiles/flutter nixpkgs.flutter
# nix-env -iA -p /nix/var/nix/profiles/dart nixpkgs.dart
# nix-env -iA -p /nix/var/nix/profiles/protobuf3_17 nixpkgs.protobuf3_17
nix-env -iA -p /nix/var/nix/profiles/jdk8 nixpkgs.jdk8
nix-env -iA -p /nix/var/nix/profiles/jdk11 nixpkgs.jdk11
nix-env -iA -p /nix/var/nix/profiles/jdk19 nixpkgs.jdk19
# nix-env -iA -p /nix/var/nix/profiles/dotnet nixpkgs.dotnet-sdk
# nix-env -iA -p /nix/var/nix/profiles/perl nixpkgs.perl
# nix-env -iA -p /nix/var/nix/profiles/python2 nixpkgs.python
# nix-env -iA -p /nix/var/nix/profiles/python3 nixpkgs.python3
# nix-env -iA -p /nix/var/nix/profiles/python39 nixpkgs.python39
# nix-env -iA -p /nix/var/nix/profiles/clang-tools_13 nixpkgs.clang-tools_13
nix-env -iA -p /nix/var/nix/profiles/llvm15 nixpkgs.clang_15
nix-env -iA -p /nix/var/nix/profiles/llvm15 nixpkgs.clang-tools_15
nix-env -iA -p /nix/var/nix/profiles/llvm15 nixpkgs.llvmPackages_15.llvm
nix-env -iA -p /nix/var/nix/profiles/llvm15-bintools nixpkgs.llvmPackages_15.bintools-unwrapped
nix-env -iA -p /nix/var/nix/profiles/inetutils nixpkgs.inetutils
# nix-env -iA -p /nix/var/nix/profiles/coreutils nixpkgs.coreutils

nix-collect-garbage

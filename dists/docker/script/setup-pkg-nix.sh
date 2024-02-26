#!/usr/bin/env bash
# Copyright (c) 2018-2024 curoky(cccuroky@gmail.com).
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
# nixpkgs.conan nixpkgs.bazel_5

pkg_list=(
  # lang
  nixpkgs.automake nixpkgs.autoconf nixpkgs.libtool nixpkgs.pkg-config nixpkgs.gnumake
  nixpkgs.ninja nixpkgs.distcc nixpkgs.ccache # nixpkgs.buck nixpkgs.scons nixpkgs.meson
  nixpkgs.clang-tools_16 nixpkgs.lld_16 nixpkgs.mold
  nixpkgs.zsh nixpkgs.bash nixpkgs.shfmt                                 # nixpkgs.shellcheck
  nixpkgs.cmake nixpkgs.cmake-format nixpkgs.bazelisk nixpkgs.buildifier # nixpkgs.cppcheck nixpkgs.include-what-you-use
  nixpkgs.go
  nixpkgs.ruby
  nixpkgs.nodejs nixpkgs.yarn nixpkgs.nodePackages.prettier nixpkgs.nodePackages.eslint
  nixpkgs.gradle nixpkgs.maven                                        # nixpkgs.ant
  nixpkgs.pipenv nixpkgs.pipx nixpkgs.ruff nixpkgs.yapf nixpkgs.black # nixpkgs.poetry
  # nixpkgs.rustc nixpkgs.cargo                                         # nixpkgs.rustup
  nixpkgs.pre-commit nixpkgs.nixpkgs-fmt
  nixpkgs.snappy
  # nixpkgs.lua nixpkgs.vlang
  # git
  nixpkgs.git nixpkgs.git-absorb nixpkgs.git-extras nixpkgs.git-lfs nixpkgs.git-filter-repo
  # nixpkgs.lazygit
  # compress
  nixpkgs.bzip2 nixpkgs.xz nixpkgs.zstd nixpkgs.zip nixpkgs.unzip nixpkgs.gnutar nixpkgs.zlib
  # sre
  nixpkgs.iproute2 nixpkgs.iputils nixpkgs.netcat nixpkgs.lsof nixpkgs.connect
  nixpkgs.procps nixpkgs.nettools nixpkgs.fd nixpkgs.ethtool nixpkgs.tcpdump nixpkgs.gdb
  nixpkgs.dstat nixpkgs.rsync nixpkgs.file nixpkgs.gperf nixpkgs.man
  nixpkgs.curl nixpkgs.wget nixpkgs.aria2 nixpkgs.croc nixpkgs.iptables
  nixpkgs.gnupg nixpkgs.tzdata nixpkgs.unixtools.xxd nixpkgs.locale nixpkgs.util-linux
  nixpkgs.findutils nixpkgs.coreutils nixpkgs.diffutils
  # nixpkgs.gost nixpkgs.htop nixpkgs.cron
  # doc
  nixpkgs.pandoc # nixpkgs.mkdocs nixpkgs.sphinx nixpkgs.hugo
  # shell
  nixpkgs.starship nixpkgs.tmux # nixpkgs.tmuxinator nixpkgs.direnv
  # editor
  nixpkgs.flex nixpkgs.bison nixpkgs.gnupatch nixpkgs.gettext nixpkgs.m4 # nixpkgs.helix
  nixpkgs.jq nixpkgs.vim nixpkgs.bat nixpkgs.less nixpkgs.gnused nixpkgs.gnugrep nixpkgs.gzip
  # nixpkgs.mcfly
  # tools
  nixpkgs.graphviz nixpkgs.asciinema nixpkgs.gdu nixpkgs.ncdu nixpkgs.silver-searcher nixpkgs.parallel
  nixpkgs.eza nixpkgs.fzf nixpkgs.cloc nixpkgs.go-task nixpkgs.krb5 nixpkgs.sqlite
  # nixpkgs.ansible nixpkgs.earthly
  # nixpkgs.vultr-cli nixpkgs.qemu
  # nixpkgs.jemalloc nixpkgs.flamegraph nixpkgs.dolt nixpkgs.watchman nixpkgs.opencc
  # nixpkgs.atuin nixpkgs.nnn nixpkgs.ranger nixpkgs.lcov nixpkgs.gcovr nixpkgs.navi nixpkgs.ghq
  # nixpkgs.sqlcipher nixpkgs.sqlite nixpkgs.zoxide nixpkgs.wishlist
  nixpkgs.ncurses5 nixpkgs.libxml2
)
nix-env -p /nix/var/nix/profiles/default -iA "${pkg_list[@]}"

# nix-env -iA -p /nix/var/nix/profiles/gcc49 nixpkgs.gcc49
# nix-env -iA -p /nix/var/nix/profiles/gcc9 nixpkgs.gcc9
# nix-env -iA -p /nix/var/nix/profiles/gcc13 nixpkgs.gcc13
# nix-env -iA -p /nix/var/nix/profiles/flutter nixpkgs.flutter
# nix-env -iA -p /nix/var/nix/profiles/dart nixpkgs.dart
# nix-env -iA -p /nix/var/nix/profiles/protobuf3_17 nixpkgs.protobuf3_17
# nix-env -iA -p /nix/var/nix/profiles/jdk8 nixpkgs.jdk8
# nix-env -iA -p /nix/var/nix/profiles/jdk11 nixpkgs.jdk11
nix-env -iA -p /nix/var/nix/profiles/jdk19 nixpkgs.jdk19
# nix-env -iA -p /nix/var/nix/profiles/dotnet nixpkgs.dotnet-sdk
# nix-env -iA -p /nix/var/nix/profiles/perl nixpkgs.perl
# nix-env -iA -p /nix/var/nix/profiles/python2 nixpkgs.python
# nix-env -iA -p /nix/var/nix/profiles/python3 nixpkgs.python3
# nix-env -iA -p /nix/var/nix/profiles/python39 nixpkgs.python39
# nix-env -iA -p /nix/var/nix/profiles/clang-tools_13 nixpkgs.clang-tools_13
nix-env -iA -p /nix/var/nix/profiles/llvm16 nixpkgs.clang_16
nix-env -iA -p /nix/var/nix/profiles/llvm16 nixpkgs.clang-tools_16
nix-env -iA -p /nix/var/nix/profiles/llvm16 nixpkgs.llvmPackages_16.llvm
nix-env -iA -p /nix/var/nix/profiles/llvm16-bintools nixpkgs.llvmPackages_16.bintools-unwrapped
nix-env -iA -p /nix/var/nix/profiles/inetutils nixpkgs.inetutils
nix-env -iA -p /nix/var/nix/profiles/protobuf_3_8_0 protobuf_3_8_0 -f default.nix
nix-env -iA -p /nix/var/nix/profiles/protobuf_3_9_2 protobuf_3_9_2 -f default.nix
nix-env -iA -p /nix/var/nix/profiles/protobuf_3_20 nixpkgs.protobuf3_20
# nix-env -iA -p /nix/var/nix/profiles/coreutils nixpkgs.coreutils

# nix-env -iA -p /nix/var/nix/profiles/cuda11_0 nixpkgs.cudaPackages_11_0.cudatoolkit
# nix-env -iA -p /nix/var/nix/profiles/cuda11_4 nixpkgs.cudaPackages_11_4.cudatoolkit
# nix-env -iA -p /nix/var/nix/profiles/cuda11_8 nixpkgs.cudaPackages_11_8.cudatoolkit

# nixpkgs.cudaPackages_11_8.nsight_compute \
# nixpkgs.cudaPackages_11_8.nsight_systems
# nixpkgs.cudaPackages_11_8.cuda_nvvp

nix-collect-garbage

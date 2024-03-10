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

pkg_list=(
  # system core package
  nixpkgs.tzdata nixpkgs.glibcLocales nixpkgs.openssh nixpkgs.cron nixpkgs.lsb-release
  nixpkgs.gnupg nixpkgs.cacert
  # c/c++
  nixpkgs.automake nixpkgs.autoconf nixpkgs.libtool nixpkgs.pkg-config nixpkgs.gnumake
  nixpkgs.ninja nixpkgs.distcc nixpkgs.ccache nixpkgs.scons nixpkgs.meson
  nixpkgs.clang-tools_16 nixpkgs.lld_16 nixpkgs.mold
  nixpkgs.cmake nixpkgs.cmake-format nixpkgs.buildifier
  nixpkgs.bazelisk # nixpkgs.conan
  # nodejs
  nixpkgs.nodejs nixpkgs.yarn nixpkgs.nodePackages.prettier nixpkgs.nodePackages.eslint
  # java
  nixpkgs.gradle nixpkgs.maven
  # python
  nixpkgs.pipenv nixpkgs.pipx
  # shell
  nixpkgs.zsh nixpkgs.bash nixpkgs.shfmt
  # other lang
  nixpkgs.go nixpkgs.perl nixpkgs.ruby
  nixpkgs.ruff nixpkgs.yapf nixpkgs.black nixpkgs.poetry
  # git
  nixpkgs.git nixpkgs.git-absorb nixpkgs.git-extras nixpkgs.git-lfs nixpkgs.git-filter-repo
  # other tools
  nixpkgs.pre-commit nixpkgs.nixpkgs-fmt
  nixpkgs.bzip2 nixpkgs.xz nixpkgs.zstd nixpkgs.zip nixpkgs.unzip nixpkgs.gnutar nixpkgs.zlib
  nixpkgs.iproute2 nixpkgs.iputils nixpkgs.netcat nixpkgs.lsof nixpkgs.connect
  nixpkgs.procps nixpkgs.nettools nixpkgs.fd nixpkgs.ethtool nixpkgs.tcpdump nixpkgs.gdb
  nixpkgs.dstat nixpkgs.rsync nixpkgs.file nixpkgs.gperf nixpkgs.man
  nixpkgs.curl nixpkgs.wget nixpkgs.aria2 nixpkgs.croc nixpkgs.iptables
  nixpkgs.gnupg nixpkgs.unixtools.xxd nixpkgs.locale nixpkgs.util-linux
  nixpkgs.findutils nixpkgs.coreutils nixpkgs.diffutils
  nixpkgs.pandoc nixpkgs.starship nixpkgs.tmux
  nixpkgs.flex nixpkgs.bison nixpkgs.gnupatch nixpkgs.gettext nixpkgs.m4
  nixpkgs.jq nixpkgs.vim nixpkgs.bat nixpkgs.less nixpkgs.gnused nixpkgs.gnugrep nixpkgs.gzip
  nixpkgs.graphviz nixpkgs.asciinema nixpkgs.gdu nixpkgs.ncdu nixpkgs.silver-searcher nixpkgs.parallel
  nixpkgs.eza nixpkgs.fzf nixpkgs.cloc nixpkgs.go-task nixpkgs.krb5 nixpkgs.sqlite nixpkgs.tree
  nixpkgs.ncurses5 nixpkgs.snappy nixpkgs.libxml2.out nixpkgs.jemalloc nixpkgs.flamegraph
  # nixpkgs.gost nixpkgs.htop
  # nixpkgs.shellcheck
  # nixpkgs.mkdocs nixpkgs.sphinx nixpkgs.hugo
  # nixpkgs.tmuxinator nixpkgs.direnv
  # nixpkgs.ansible
  # nixpkgs.earthly
  # nixpkgs.vultr-cli nixpkgs.qemu
  # nixpkgs.dolt nixpkgs.watchman nixpkgs.opencc
  # nixpkgs.lcov nixpkgs.gcovr nixpkgs.ghq
  # nixpkgs.sqlcipher nixpkgs.sqlite nixpkgs.zoxide
)
nix-env -p /nix/var/nix/profiles/default -iA "${pkg_list[@]}"

nix-env -iA -p /nix/var/nix/profiles/jdk19 nixpkgs.jdk19
nix-env -iA -p /nix/var/nix/profiles/gcc9 nixpkgs.gcc9
nix-env -iA -p /nix/var/nix/profiles/gcc13 nixpkgs.gcc13
# nix-env -iA -p /nix/var/nix/profiles/llvm16 nixpkgs.clang_16 nixpkgs.clang-tools_16 nixpkgs.llvmPackages_16.llvm
# nix-env -iA -p /nix/var/nix/profiles/llvm16-bintools nixpkgs.llvmPackages_16.bintools-unwrapped
# nix-env -iA -p /nix/var/nix/profiles/inetutils nixpkgs.inetutils
nix-env -iA -p /nix/var/nix/profiles/default2 -f default.nix conan licenseheaders dotdrop
ln -s /nix/var/nix/profiles/default2/bin/* /nix/var/nix/profiles/default/bin/

#################### protobuf ####################
nix-env -iA -p /nix/var/nix/profiles/protobuf_3_8_0 -f default.nix protobuf_3_8_0
nix-env -iA -p /nix/var/nix/profiles/protobuf_3_9_2 -f default.nix protobuf_3_9_2
nix-env -iA -p /nix/var/nix/profiles/protobuf_3_20 nixpkgs.protobuf3_20

#################### cuda ####################
nix-env -iA -p /nix/var/nix/profiles/cuda11_4 nixpkgs.cudaPackages_11_4.cudatoolkit nixpkgs.cudaPackages_11_4.cudatoolkit.lib
ln -s /nix/var/nix/profiles/cuda11_4/lib/libcudart.* /nix/var/nix/profiles/cuda11_4/lib64/
# nix-env -iA -p /nix/var/nix/profiles/cuda12_2 nixpkgs.cudaPackages_12_2.cudatoolkit nixpkgs.cudaPackages_12_2.cudatoolkit.lib
# nix-env -iA -p /nix/var/nix/profiles/cuda11_42 nixpkgs.cudaPackages_11_4.cuda_nvcc nixpkgs.cudaPackages_11_4.cuda_cudart
# nixpkgs.cudaPackages.nsight_systems nsight_compute cuda_nvvp

#################### zsh-bundle ####################
nix-env -iA -p /nix/var/nix/profiles/zsh-bundle -f default.nix zsh-bundle

#################### vim-bundle ####################
nix-env -iA -p /nix/var/nix/profiles/vim-bundle -f default.nix vim-bundle

#################### nix-init ####################
# nix run --extra-experimental-features "flakes nix-command" github:nix-community/nix-init -- --help

#################### post patch ####################
ln -s /nix/var/nix/profiles/default/bin/bazelisk /nix/var/nix/profiles/default/bin/bazel

nix-collect-garbage

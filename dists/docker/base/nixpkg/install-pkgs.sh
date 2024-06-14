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

pkg_list=(
  # system core package
  nixpkgs.tzdata.out nixpkgs.glibcLocales nixpkgs.locale
  # compression
  nixpkgs.bzip2 nixpkgs.xz nixpkgs.zstd nixpkgs.zip nixpkgs.unzip nixpkgs.gnutar nixpkgs.zlib nixpkgs.zlib-ng nixpkgs.gzip nixpkgs.snappy
  # download
  nixpkgs.gnupg nixpkgs.cacert nixpkgs.curl nixpkgs.wget nixpkgs.aria2 nixpkgs.rsync
  # edit
  nixpkgs.less nixpkgs.gnused nixpkgs.gnugrep nixpkgs.vim nixpkgs.bat nixpkgs.jq
  nixpkgs.flex nixpkgs.bison nixpkgs.gettext nixpkgs.m4
  # SRE
  nixpkgs.iproute2 nixpkgs.iputils nixpkgs.netcat nixpkgs.lsof nixpkgs.connect nixpkgs.procps
  nixpkgs.nettools nixpkgs.fd nixpkgs.ethtool nixpkgs.gdb nixpkgs.file nixpkgs.eza nixpkgs.fzf
  nixpkgs.dstat nixpkgs.man nixpkgs.iptables nixpkgs.unixtools.xxd nixpkgs.util-linux
  nixpkgs.findutils nixpkgs.coreutils nixpkgs.lsb-release nixpkgs.tree
  nixpkgs.gdu nixpkgs.ncdu nixpkgs.silver-searcher nixpkgs.diffutils
  nixpkgs.jemalloc nixpkgs.flamegraph nixpkgs.patchelf nixpkgs.strace
  # libraries
  # c/c++
  nixpkgs.automake nixpkgs.autoconf nixpkgs.libtool nixpkgs.pkg-config nixpkgs.gnumake
  nixpkgs.ninja nixpkgs.distcc nixpkgs.ccache nixpkgs.scons nixpkgs.meson
  nixpkgs.cmake nixpkgs.cmake-format nixpkgs.buildifier nixpkgs.bazelisk
  nixpkgs.clang-tools_16 # nixpkgs.conan nixpkgs.mold nixpkgs.lld_16
  # nodejs
  nixpkgs.nodejs nixpkgs.yarn nixpkgs.nodePackages.prettier nixpkgs.nodePackages.eslint
  # java
  # nixpkgs.gradle nixpkgs.maven
  # python
  nixpkgs.pipenv nixpkgs.pipx nixpkgs.ruff nixpkgs.poetry # nixpkgs.yapf nixpkgs.black
  # shell
  nixpkgs.zsh nixpkgs.bash nixpkgs.shfmt nixpkgs.starship nixpkgs.tmux nixpkgs.asciinema
  # other lang
  nixpkgs.go nixpkgs.perl nixpkgs.ruby
  # git
  nixpkgs.git nixpkgs.git-absorb nixpkgs.git-extras nixpkgs.git-lfs nixpkgs.git-filter-repo nixpkgs.gnupatch
  # other tools
  nixpkgs.nix-index nixpkgs.nixpkgs-fmt nixpkgs.pre-commit nixpkgs.gperf
  nixpkgs.openssh_gssapi nixpkgs.pandoc nixpkgs.graphviz
  nixpkgs.parallel nixpkgs.cloc nixpkgs.go-task nixpkgs.krb5 nixpkgs.sqlite

  # nixpkgs.gost nixpkgs.htop nixpkgs.tcpdump nixpkgs.shellcheck
  # nixpkgs.mkdocs nixpkgs.sphinx nixpkgs.hugo nixpkgs.inetutils
  # nixpkgs.tmuxinator nixpkgs.direnv nixpkgs.ansible nixpkgs.croc
  # nixpkgs.earthly nixpkgs.vultr-cli nixpkgs.qemu
  # nixpkgs.dolt nixpkgs.watchman nixpkgs.opencc nixpkgs.lcov nixpkgs.gcovr nixpkgs.ghq
  # nixpkgs.sqlcipher nixpkgs.sqlite nixpkgs.zoxide
  # nixpkgs.cron
)
nix-env -p /nix/var/nix/profiles/default -iA "${pkg_list[@]}"

chmod +w /nix/var/nix/profiles/default/*
ln -s /nix/var/nix/profiles/default/bin/bazelisk /nix/var/nix/profiles/default/bin/bazel

nix-env -iA -p /nix/var/nix/profiles/libs nixpkgs.python311Packages.libtorrent-rasterbar \
  nixpkgs.ncurses5 nixpkgs.libxml2.out nixpkgs.libxcrypt nixpkgs.libbacktrace

#################### jdk ####################
# nix-env -iA -p /nix/var/nix/profiles/jdk19 nixpkgs.jdk19
nix-env -iA -p /nix/var/nix/profiles/jdk nixpkgs.jdk

#################### llvm ####################
# nix-env -iA -p /nix/var/nix/profiles/llvm16 nixpkgs.clang_16 nixpkgs.clang-tools_16 nixpkgs.llvmPackages_16.llvm
# nix-env -iA -p /nix/var/nix/profiles/llvm16-bintools nixpkgs.llvmPackages_16.bintools-unwrapped

#################### gcc ####################
function install_gcc() {
  version=${1:-13}
  nix-env -iA -p /nix/var/nix/profiles/gcc$version nixpkgs.gcc$version
  nix-env -iA -p /nix/var/nix/profiles/gcc$version-lib nixpkgs.gcc$version.cc.lib
  nix-env -iA -p /nix/var/nix/profiles/gcc$version-unwrapper nixpkgs.gcc$version.cc
  chmod +w /nix/var/nix/profiles/gcc$version-unwrapper/*
  ln -s /nix/var/nix/profiles/libs/include/crypt.h /nix/var/nix/profiles/gcc$version-unwrapper/include
  ln -s /nix/var/nix/profiles/libs/include/backtrace.h /nix/var/nix/profiles/gcc$version-unwrapper/include
  ln -s /nix/var/nix/profiles/libs/lib/libbacktrace.* /nix/var/nix/profiles/gcc$version-unwrapper/lib
}
# install_gcc 8
# install_gcc 10
# install_gcc 13

# nix-env -iA -p /nix/var/nix/profiles/libgcc nixpkgs.libgcc
# gcc13_wrapper_root=$(realpath /nix/var/nix/profiles/gcc13/bin)/../
# echo "-I/usr/include" >$gcc13_wrapper_root/nix-support/libcxx-cxxflags
# gcc13_root=$(dirname "$(/nix/var/nix/profiles/gcc13/bin/gcc -v 2>&1 | grep "COLLECT_GCC" | cut -d '=' -f 2)")/..
# ln -s /nix/var/nix/profiles/default/include/crypt.h $gcc13_root/include
# ln -s /nix/var/nix/profiles/default/include/backtrace.h $gcc13_root/include
# ln -s /nix/var/nix/profiles/default/lib/libbacktrace.* $gcc13_root/lib

#################### protobuf ####################
nix-env -iA -p /nix/var/nix/profiles/protobuf_3_8_0 -f default.nix protobuf_3_8_0
nix-env -iA -p /nix/var/nix/profiles/protobuf_3_9_2 -f default.nix protobuf_3_9_2
nix-env -iA -p /nix/var/nix/profiles/protobuf_3_20 nixpkgs.protobuf3_20
nix-env -iA -p /nix/var/nix/profiles/protobuf_24 nixpkgs.protobuf_24

#################### cuda ####################
nix-env -iA -p /nix/var/nix/profiles/nsight-systems -f default.nix nsight-systems
# nix-env -iA -p /nix/var/nix/profiles/cu12_cudnn_8_9_7_29 nixpkgs.cudaPackages_12.cudnn_8_9
nix-env -iA -p /nix/var/nix/profiles/cu11_cudnn_8_9_7_29 nixpkgs.cudaPackages_11.cudnn_8_9
# nix-env -iA -p /nix/var/nix/profiles/cuda11_0 nixpkgs.cudaPackages_11_0.cudatoolkit
# nix-env -iA -p /nix/var/nix/profiles/cuda11_4 nixpkgs.cudaPackages_11_4.cudatoolkit nixpkgs.cudaPackages_11_4.cudatoolkit.lib
# chmod +w /nix/var/nix/profiles/cuda11_4/*
# ln -s /nix/var/nix/profiles/cuda11_4/lib/libcudart.* /nix/var/nix/profiles/cuda11_4/lib64/
# nix-env -iA -p /nix/var/nix/profiles/cuda12_2 nixpkgs.cudaPackages_12_2.cudatoolkit nixpkgs.cudaPackages_12_2.cudatoolkit.lib
# nix-env -iA -p /nix/var/nix/profiles/cuda11_42 nixpkgs.cudaPackages_11_4.cuda_nvcc nixpkgs.cudaPackages_11_4.cuda_cudart
# nixpkgs.cudaPackages.nsight_systems nsight_compute cuda_nvvp
# nix-env -iA -p /nix/var/nix/profiles/cu12_tensorrt_8_6 nixpkgs.cudaPackages.tensorrt

#################### zsh-bundle ####################
nix-env -iA -p /nix/var/nix/profiles/zsh-bundle -f default.nix zsh-bundle

#################### vim-bundle ####################
nix-env -iA -p /nix/var/nix/profiles/vim-bundle -f default.nix vim-bundle

#################### nix-init ####################
# nix run --extra-experimental-features "flakes nix-command" github:nix-community/nix-init -- --help

#################### nix-index ####################
# nix-index

nix-collect-garbage

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
  nixpkgs.bzip2 nixpkgs.xz nixpkgs.zstd nixpkgs.zip nixpkgs.unzip nixpkgs.gnutar nixpkgs.zlib nixpkgs.gzip nixpkgs.snappy
  # download
  nixpkgs.gnupg nixpkgs.cacert nixpkgs.curl nixpkgs.wget nixpkgs.aria2 nixpkgs.rsync
  # edit
  nixpkgs.less nixpkgs.gnused nixpkgs.gnugrep nixpkgs.vim nixpkgs.bat nixpkgs.diffutils nixpkgs.jq
  nixpkgs.flex nixpkgs.bison nixpkgs.gettext nixpkgs.m4
  # SRE
  nixpkgs.iproute2 nixpkgs.iputils nixpkgs.netcat nixpkgs.lsof nixpkgs.connect nixpkgs.procps
  nixpkgs.nettools nixpkgs.fd nixpkgs.ethtool nixpkgs.gdb nixpkgs.file nixpkgs.eza nixpkgs.fzf
  nixpkgs.dstat nixpkgs.man nixpkgs.iptables nixpkgs.unixtools.xxd nixpkgs.util-linux
  nixpkgs.findutils nixpkgs.coreutils nixpkgs.cron nixpkgs.lsb-release nixpkgs.tree
  nixpkgs.gdu nixpkgs.ncdu nixpkgs.silver-searcher nixpkgs.sqlite
  # libraries
  nixpkgs.ncurses5 nixpkgs.libxml2.out nixpkgs.libxcrypt nixpkgs.libbacktrace nixpkgs.jemalloc nixpkgs.flamegraph
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
  nixpkgs.pipenv nixpkgs.pipx nixpkgs.ruff nixpkgs.yapf nixpkgs.black nixpkgs.poetry
  # shell
  nixpkgs.zsh nixpkgs.bash nixpkgs.shfmt nixpkgs.starship nixpkgs.tmux nixpkgs.asciinema
  # other lang
  nixpkgs.go
  nixpkgs.perl
  nixpkgs.ruby
  nixpkgs.nix-index nixpkgs.nixpkgs-fmt
  # git
  nixpkgs.git nixpkgs.git-absorb nixpkgs.git-extras nixpkgs.git-lfs nixpkgs.git-filter-repo nixpkgs.gnupatch
  # other tools
  nixpkgs.pre-commit nixpkgs.gperf nixpkgs.openssh nixpkgs.pandoc nixpkgs.graphviz
  nixpkgs.parallel nixpkgs.cloc nixpkgs.go-task nixpkgs.krb5

  # nixpkgs.gost nixpkgs.htop nixpkgs.tcpdump nixpkgs.shellcheck
  # nixpkgs.mkdocs nixpkgs.sphinx nixpkgs.hugo nixpkgs.inetutils
  # nixpkgs.tmuxinator nixpkgs.direnv nixpkgs.ansible nixpkgs.croc
  # nixpkgs.earthly nixpkgs.vultr-cli nixpkgs.qemu
  # nixpkgs.dolt nixpkgs.watchman nixpkgs.opencc nixpkgs.lcov nixpkgs.gcovr nixpkgs.ghq
  # nixpkgs.sqlcipher nixpkgs.sqlite nixpkgs.zoxide
)
nix-env -p /nix/var/nix/profiles/default -iA "${pkg_list[@]}"

chmod +w /nix/var/nix/profiles/default/*
nix-env -iA -p /nix/var/nix/profiles/default2 -f default.nix conan dotdrop licenseheaders
ln -s /nix/var/nix/profiles/default2/bin/* /nix/var/nix/profiles/default/bin/
ln -s /nix/var/nix/profiles/default/bin/bazelisk /nix/var/nix/profiles/default/bin/bazel

#################### jdk ####################
nix-env -iA -p /nix/var/nix/profiles/jdk19 nixpkgs.jdk19

#################### llvm ####################
# nix-env -iA -p /nix/var/nix/profiles/llvm16 nixpkgs.clang_16 nixpkgs.clang-tools_16 nixpkgs.llvmPackages_16.llvm
# nix-env -iA -p /nix/var/nix/profiles/llvm16-bintools nixpkgs.llvmPackages_16.bintools-unwrapped

#################### gcc ####################
nix-env -iA -p /nix/var/nix/profiles/gcc9 nixpkgs.gcc9
nix-env -iA -p /nix/var/nix/profiles/gcc9-lib nixpkgs.gcc9.cc.lib
nix-env -iA -p /nix/var/nix/profiles/gcc9-unwrapper nixpkgs.gcc9.cc
nix-env -iA -p /nix/var/nix/profiles/gcc13 nixpkgs.gcc13
nix-env -iA -p /nix/var/nix/profiles/gcc13-lib nixpkgs.gcc13.cc.lib
nix-env -iA -p /nix/var/nix/profiles/gcc13-unwrapper nixpkgs.gcc13.cc
nix-env -iA -p /nix/var/nix/profiles/libgcc nixpkgs.libgcc

chmod +w /nix/var/nix/profiles/gcc13-unwrapper/*
ln -s /nix/var/nix/profiles/default/include/crypt.h /nix/var/nix/profiles/gcc13-unwrapper/include
ln -s /nix/var/nix/profiles/default/include/backtrace.h /nix/var/nix/profiles/gcc13-unwrapper/include
ln -s /nix/var/nix/profiles/default/lib/libbacktrace.* /nix/var/nix/profiles/gcc13-unwrapper/lib
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

#################### cuda ####################
nix-env -iA -p /nix/var/nix/profiles/cuda11_4 nixpkgs.cudaPackages_11_4.cudatoolkit nixpkgs.cudaPackages_11_4.cudatoolkit.lib
chmod +w /nix/var/nix/profiles/cuda11_4/*
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

#################### nix-index ####################
# nix-index

nix-collect-garbage
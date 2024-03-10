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

#=-> homebrew
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_BOOTSNAP=1
export HOMEBREW_BAT=1
export HOMEBREW_BAT_CONFIG_PATH=$HOME/.config/bat/config
export HOMEBREW_CC=gcc
export HOMEBREW_GIT_PATH=/nix/var/nix/profiles/default/bin/git
# export HOMEBREW_PATCHELF_RB_WRITE=1
# export HOMEBREW_EDITOR=code
# export HOMEBREW_TEMP=$XDG_CACHE_HOME/brew  # default: ~/tmp
# export HOMEBREW_NO_INSTALLED_DEPENDENTS_CHECK=1
# export HOMEBREW_CACHE=$XDG_CACHE_HOME/homebrew # get with brew --cache
# export HOMEBREW_INSTALL_FROM_API=1

#=-> flutter
# export PUB_HOSTED_URL="https://mirrors.tuna.tsinghua.edu.cn/dart-pub/"
# export PUB_HOSTED_URL="https://mirrors.cloud.tencent.com/dart-pub/"
# export FLUTTER_STORAGE_BASE_URL="https://mirrors.tuna.tsinghua.edu.cn/flutter"
# export FLUTTER_STORAGE_BASE_URL="https://mirrors.cloud.tencent.com/flutter/"
# export ANDROID_HOME=~/Library/Android

#=-> gcc
# https://reversed.top/2015-10-25/enable-colorization-of-gcc-output/
# export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
# export CC=/home/linuxbrew/.linuxbrew/opt/gcc@10/bin/gcc-10
# export CXX=/home/linuxbrew/.linuxbrew/opt/gcc@10/bin/g++-10

#=-> npm
# https://docs.npmjs.com/cli/v6/using-npm/config#environment-variables
# https://reactgo.com/npm-change-cache-location/
export NPM_CONFIG_CACHE=$XDG_CACHE_HOME/npm
# export NPM_CONFIG_PREFIX=$HOME/.npm-global
# export NPM_CONFIG_REGISTRY=https://registry.npm.taobao.org

#=-> git
# export FILTER_BRANCH_SQUELCH_WARNING=1

#=-> docker
# export DOCKER_CLIENT_TIMEOUT=120
# export COMPOSE_HTTP_TIMEOUT=120

#=-> Krb5
# export KRB5_CONFIG=$CONFIG_HOME/krb5/krb5.conf
export KRB5CCNAME=/tmp/krb5_ccache

#=-> distcc
# export DISTCC_IO_TIMEOUT=10000
# export DISTCC_SKIP_LOCAL_RETRY=1
export DISTCC_HOSTS="--localslots_cpp=32 --randomize 10.144.189.196/600"
export DISTCC_LOG=$XDG_CACHE_HOME/distcc.log
# export DISTCC_DIR=$XDG_CACHE_HOME/distcc
# export DISTCC_VERBOSE=1
# export DISABLE_CAS=1

#=-> ccache already enabled by default
# https://ccache.dev/manual/latest.html#config_cache_dir
# export CCACHE_CONFIGPATH=$CONFIG_HOME/ccache/ccache.conf
# export CCACHE_DIR=$XDG_CACHE_HOME/ccache

#=-> vim-plugin
# export VIM_PLUGIN_PATH=$HOMEBREW_PREFIX/opt/vim-bundle/vim-plugin
# https://stackoverflow.com/questions/4618151/how-to-reference-source-a-custom-vimrc-file
# export VIMINIT="source ${__VIM_RC_PATH}"
# alias vim="vim -u ${__VIM_RC_PATH}"

#=-> python & pip
# export PYTHONWARNINGS=ignore:DEPRECATION
# export PYTHONWARNINGS="ignore::DeprecationWarning"
# https://pip.pypa.io/en/latest/topics/configuration/#environment-variables
# https://pip.pypa.io/en/latest/topics/caching/#default-paths
# export PIP_CACHE_DIR=$XDG_CACHE_HOME/pip
# export PIP_CONFIG_FILE=$CONFIG_HOME/pip/pip.conf
# https://docs.python.org/3/using/cmdline.html#environment-variables
# export PYTHONPATH=$p:$PYTHONPATH

#=-> go
# https://pkg.go.dev/cmd/go#hdr-Build_and_test_caching
# export GOCACHE=$XDG_CACHE_HOME/go-build
export GOENV=$CONFIG_HOME/go/env

#=-> rubocop
# https://docs.rubocop.org/rubocop/usage/caching.html#cache-path
# export RUBOCOP_CACHE_ROOT=$XDG_CACHE_HOME/rubocop

#=-> starship
# https://starship.rs/config/#logging
# export STARSHIP_CACHE=$XDG_CACHE_HOME/starship

#=-> dool(dstat's fork)
# https://github.com/scottchiefbaker/dool/blob/master/docs/dool.1.adoc#environment-variables
# export DSTAT_OPTS="--bw"

#=-> navi
# eval "$(navi widget zsh)"

#=-> ghq
# export GHQ_ROOT=

#=-> cpm
# export CPM_SOURCE_CACHE=$XDG_CACHE_HOME/cpm

#=->vcpkg
# export VCPKG_DOWNLOADS=$XDG_CACHE_HOME/vcpkg/download

#=-> atuin
# export ATUIN_NOBIND="true"
# export ATUIN_CONFIG_DIR=$CONFIG_HOME/atuin

#=-> bat
# export BAT_CONFIG_PATH=$CONFIG_HOME/bat/config

#=-> starship
# export STARSHIP_CONFIG=$CONFIG_HOME/starship/starship.toml

#=-> navi
# export NAVI_CONFIG=$CONFIG_HOME/navi/config.yaml

#-> htop
# export HTOPRC=$CONFIG_HOME/htop/htoprc

#-> conda
# https://docs.conda.io/projects/conda/en/latest/user-guide/configuration/use-condarc.html#id4
# export CONDARC=$CONFIG_HOME/conda/condarc

#-> zoxide
# export _ZO_DATA_DIR=$XDG_CACHE_HOME/zoxide

#-> nix
# https://nixos.wiki/wiki/Locales
# export LOCALE_ARCHIVE=/usr/lib/locale/locale-archive

#-> java
export JAVA_HOME=/nix/var/nix/profiles/jdk19
if [[ ! -d $JAVA_HOME ]]; then
  export JAVA_HOME=/opt/homebrew/opt/openjdk@17
fi

#-> cuda
export CUDA_HOME=/nix/var/nix/profiles/cuda11_4

#!/usr/bin/env bash
set -xeuo pipefail

function setup-brew() {
  export NONINTERACTIVE=1
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
}

function setup-dotfiles() {
  if [[ -f /opt/homebrew/bin/dotdrop ]]; then
    brew install dotdrop
  fi
  dotdrop install --cfg=~/dotbox/config.yaml --force --profile=macos-user-base
}

function setup-brew-pkgs() {
  mkdir -p /opt/homebrew/Library/Taps/curoky/
  ln -sf ~/dotbox/third-party/homebrew/ /opt/homebrew/Library/Taps/curoky/homebrew-tap
  brew bundle --force --file ~/dotbox/dists/osx-host/conf/brew/Brewfile --cleanup --verbose
  brew link krb5 --force
  brew cleanup --prune=all
}

function setup-conda-pkgs() {
  ~/dotbox/dists/osx-host/setup-conda-pkgs.sh
}

####################### start ######################
if [[ ! -f /opt/homebrew/bin/brew ]]; then
  setup-brew
fi

setup-dotfiles
setup-brew-pkgs

if [[ ! -d /opt/homebrew/Caskroom/miniconda/base/envs/py3 ]]; then
  setup-conda-pkgs
fi

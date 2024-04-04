#!/usr/bin/env bash

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"

brew install dotdrop

dotdrop install --cfg=~/repos/dotbox/config.yaml --force --profile=macos-userconf

brew bundle --force --file ~/repos/dotbox/dists/docker/config/brew/Brewfile.osx-persional --cleanup --verbose

/Users/curoky/repos/dotbox/dists/docker/script/setup-pkg-conda-osx.sh

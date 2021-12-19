#!/usr/bin/env bash
# Copyright 2019 curoky(cccuroky@gmail.com).
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
set -euo pipefail

function try_link() {
  local src=$1
  local dst=$2

  if [[ ! -d $src ]]; then
    echo "$src not exist"
    return
  fi
  # if [ -e "$dst" ]; then
  #   echo "$dst already exist"
  #   return
  # fi

  echo "link $src to $dst"
  rm -rf $dst
  ln -s $src $dst
}

try_link $HOME/repos/vscode-server $HOME/.vscode-server
try_link $HOME/repos/homebrew-tap "$(brew --prefix)/Homebrew/Library/Taps/curoky/homebrew-tap"
try_link $HOME/repos/static-binaries "$(brew --prefix)/Homebrew/Library/Taps/curoky/homebrew-static-binaries"
try_link $HOME/repos/my-own-x/python/lib "$(brew --prefix python@3)/lib/python3.9/mox"

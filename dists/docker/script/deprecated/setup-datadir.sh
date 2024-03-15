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
set -euo pipefail

function try_link_to() {
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

sudo mkdir -p /data/workspace /data/share /data/cache/vscode-server
sudo chown -R cicada:cicada /data/workspace /data/share /data/cache/vscode-server

try_link_to /data/cache $HOME/.cache
try_link_to /data/cache/vscode-server $HOME/.vscode-server
try_link_to /data/share/dotbox $HOME/dotbox

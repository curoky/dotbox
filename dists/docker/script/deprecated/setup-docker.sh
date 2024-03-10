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

OS_NAME=$(grep "^ID=" /etc/os-release | cut -d'=' -f2 | tr -d '"')
VERSION_ID=$(grep "^VERSION_ID=" /etc/os-release | cut -d'=' -f2 | tr -d '"')

if [[ $OS_NAME == "ubuntu" ]]; then
  if [[ $VERSION_ID == "22.04" ]]; then
    PREFIX=https://download.docker.com/linux/ubuntu/dists/impish/pool/stable/amd64

    curl -sSL $PREFIX/containerd.io_1.4.11-1_amd64.deb \
      -o containerd.io.deb
    curl -sSL $PREFIX/docker-ce_20.10.10~3-0~ubuntu-impish_amd64.deb \
      -o docker-ce.deb
    curl -sSL $PREFIX/docker-ce-cli_20.10.10~3-0~ubuntu-impish_amd64.deb \
      -o docker-ce-cli.deb

    curl -sSL $PREFIX/docker-scan-plugin_0.9.0~ubuntu-impish_amd64.deb \
      -o docker-scan-plugin.deb

    dpkg -i ./*.deb
    rm -rf ./*.deb
    exit 0
  fi
fi

# use script
sh -c "$(curl -fsSL https://get.docker.com/)"

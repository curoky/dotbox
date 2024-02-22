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

# apt install -y libtinfo5
# curl -sSL -o libtinfo5_6.4-2_amd64.deb http://security.ubuntu.com/ubuntu/pool/universe/n/ncurses/libtinfo5_6.4-2_amd64.deb

# ln -s /nix/var/nix/profiles/default/lib/libz.so* /usr/lib/x86_64-linux-gnu/
# ln -s /nix/var/nix/profiles/default/lib/libtinfo.so* /usr/lib/x86_64-linux-gnu/
ln -s /nix/var/nix/profiles/default/lib/libsnappy.so* /usr/lib/x86_64-linux-gnu/

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

# ln -s /nix/var/nix/profiles/default/lib/libz.so* /usr/lib/x86_64-linux-gnu/
ln -s /nix/var/nix/profiles/default/lib/libtinfo.so* /usr/lib/x86_64-linux-gnu/
ln -s /nix/var/nix/profiles/default/lib/libsnappy.* /usr/lib/x86_64-linux-gnu/
ln -s /nix/var/nix/profiles/libxml2/lib/libxml2.* /usr/lib/x86_64-linux-gnu/
ln -s /nix/var/nix/profiles/default/bin/less /usr/bin/less
ln -s /nix/var/nix/profiles/default/bin/git /usr/bin/git

# timezone
ln -fs /nix/var/nix/profiles/default/share/zoneinfo/Singapore /etc/localtime

# cert
mkdir -p /etc/ssl/certs/
cp /nix/var/nix/profiles/default/etc/ssl/certs/ca-bundle.crt /etc/ssl/certs/ca-certificates.crt
ln -s /nix/var/nix/profiles/default/include/crypt.h /usr/include/crypt.h

# locales
mkdir -p /usr/lib/locale
ln -s /nix/var/nix/profiles/default/lib/locale/locale-archive /usr/lib/locale/locale-archive
echo 'LANG=en_US.UTF-8' >/etc/locale.conf

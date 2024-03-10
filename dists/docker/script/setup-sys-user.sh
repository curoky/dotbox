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

function CreateUser() {
  uid=$1
  gid=$uid
  name=$2
  pass=$3
  echo "create user $name($uid:$gid) with password: $pass"
  groupadd -g $gid -o $name
  useradd -m -s /nix/var/nix/profiles/default/bin/zsh -u $uid -g $gid $name
  echo "$name:$pass" | chpasswd
  usermod -aG adm $name
  # usermod -aG docker $name
  usermod -aG sudo $name
  echo "$name ALL=(ALL:ALL) NOPASSWD:ALL" >>/etc/sudoers.d/nopasswd_user
}

echo "root:123456" | chpasswd

if id ubuntu; then
  userdel ubuntu && rm -rf /home/ubuntu
fi

CreateUser 1000 cicada 123456

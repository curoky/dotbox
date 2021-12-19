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

set -xeuo pipefail

function CreateUser() {
  uid=$1
  gid=$uid
  name=$2
  pass=$3
  groupadd -g $gid -o $name
  useradd -m -s /home/linuxbrew/.linuxbrew/bin/zsh -u $uid -g $gid $name
  usermod -aG sudo $name
  usermod -aG adm $name
  usermod -aG docker $name
  echo "$name:$pass" | chpasswd
  echo "create user $name($uid:$gid) with password: $pass"
  echo "$name ALL=(ALL:ALL) NOPASSWD:ALL" >>/etc/sudoers
}

CreateUser 1000 curoky 123456
CreateUser 1001 worker 123456

usermod -aG curoky worker

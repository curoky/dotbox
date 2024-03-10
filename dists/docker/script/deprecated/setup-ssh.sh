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

OP=$1

mkdir -p ~/.ssh

if [[ $OP == "download" ]]; then
  URL=$2

  curl -sSL $URL/cleasing-milk.txt -o ~/.ssh/id_rsa.pub.sha256
  curl -sSL $URL/soy-milk.txt -o ~/.ssh/id_rsa.sha256
elif [[ $OP == "decrypt" ]]; then
  PASSWORD=$2

  openssl aes-128-cbc -nosalt -md sha256 -k $PASSWORD -base64 -d <~/.ssh/id_rsa.pub.sha256 >~/.ssh/id_rsa.pub
  openssl aes-128-cbc -nosalt -md sha256 -k $PASSWORD -base64 -d <~/.ssh/id_rsa.sha256 >~/.ssh/id_rsa

  chmod 600 ~/.ssh/id_rsa ~/.ssh/id_rsa.pub

  if ! grep "$(ssh-keyscan github.com 2>/dev/null)" ~/.ssh/known_hosts >/dev/null; then
    ssh-keyscan github.com >>~/.ssh/known_hosts 2>/dev/null
  fi
elif [[ $OP == "cleanup" ]]; then
  rm -f ~/.ssh/id_rsa.pub ~/.ssh/id_rsa
else
  echo "unknown operation"
  exit 1
fi

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

function generate-apt-lockfile() {
  output_path=$1
  osname=$(cat /etc/os-release | grep -E "^ID=\w*" | cut -d"=" -f2)
  osversion=$(lsb_release -rs | tr -d '"')
  apt list --installed >$output_path/$osname-$osversion-apt-list.txt
}

function generate-conda-lockfile() {
  output_path=$1
  env_name=$2
  conda env export -n $env_name >$output_path/conda-$env_name.yaml
}

function lock() {
  root="$1"
  rm -rf $root
  mkdir -p $root
  generate-apt-lockfile $root
  generate-conda-lockfile $root tf2.16-cpu
  generate-conda-lockfile $root tf2.11
  generate-conda-lockfile $root py3
  generate-conda-lockfile $root py2
}

lock "$(date +%Y-%m-%d)"
lock "latest"

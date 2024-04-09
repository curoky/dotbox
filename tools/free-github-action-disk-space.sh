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

# https://raw.githubusercontent.com/apache/flink/master/tools/azure-pipelines/free_disk_space.sh
# https://github.com/marketplace/actions/free-disk-space-ubuntu

df -h

sudo apt-get update -y
sudo apt purge -y \
  aspnetcore* ant* apache2 azure-cli dotnet* firefox g++-{7,8,9,10,11,12} gcc-{7,8,9,10,11,12} \
  gh google-* libllvm* linux-azure-* lldb-* llvm-* microsoft-* \
  mongodb-* mono-* mysql-* nginx openjdk-* php* postgresql* powershell \
  r-* snapd temurin-* podman
df -h

sudo apt-get autoremove
df -h

rustup self uninstall -y
df -h

docker system prune -a -f
df -h

sudo rm -rf \
  /home/runneradmin/.cargo \
  /home/runneradmin/.rustup \
  /imagegeneration/installers \
  /opt/hostedtoolcache \
  /opt/pipx \
  /opt/runner/provisioner \
  /root/.sbt \
  /usr/local/.ghcup \
  /usr/local/bin/oc \
  /usr/local/bin/packer \
  /usr/local/bin/pulumi \
  /usr/local/julia* \
  /usr/local/graalvm \
  /usr/local/lib/android \
  /usr/local/lib/heroku \
  /usr/local/lib/node_modules \
  /usr/local/share/chromium \
  /usr/local/share/powershell \
  /usr/share/az_* \
  /usr/share/dotnet \
  /usr/share/gradle-* \
  /usr/share/kotlinc \
  /usr/share/miniconda \
  /usr/share/sbt \
  /usr/share/swift
df -h

free

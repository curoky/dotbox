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

CONF_PATH=${1:-/app/dotbox/config}

function copy_path() {
  src=$1
  dst=$2
  force=${3:-0}
  if [[ ! -e $src ]]; then
    echo "Path $src does not exist"
    if [[ $force -eq 0 ]]; then
      return
    fi
  fi
  if [[ -e $dst ]]; then
    echo "Path $dst already exists, remove it"
    rm -rf $dst
  fi
  mkdir -p $(dirname $dst)
  cp -r $src $dst
  echo "Copied $src to $dst"
}

function link_path() {
  src=$1
  dst=$2
  force=${3:-0}
  if [[ ! -e $src ]]; then
    echo "Path $src does not exist"
    if [[ $force -eq 0 ]]; then
      return
    fi
  fi
  if [[ -e $dst ]]; then
    echo "Path $dst already exists, remove it"
    rm -rf $dst
  fi
  mkdir -p $(dirname $dst)
  ln -s $src $dst
  echo "Linked $src to $dst"
}

apt-get update -y

# install sudo
apt-get install -y sudo zsh

# remove user ubuntu
userdel ubuntu -r || echo "ignore userdel failed"

# update user root
echo "root:123456" | chpasswd
chsh -s /usr/bin/zsh

# add user x
useradd --create-home --shell /usr/bin/zsh --uid 1000 --user-group x
echo "x:123456" | chpasswd
usermod -aG sudo x
echo "x ALL=(ALL:ALL) NOPASSWD:ALL" >>/etc/sudoers.d/nopasswd_user

# add ca-certificates
copy_path $CONF_PATH/linux/ssl/ca-bundle.crt /etc/ssl/certs/ca-certificates.crt

# sudoers
copy_path $CONF_PATH/linux/sudoers.d/more_secure_path /etc/sudoers.d/more_secure_path

# sysctl
copy_path $CONF_PATH/linux/sysctl.d/custom.conf /etc/sysctl.d/custom.conf

# ssh && sshd
copy_path $CONF_PATH/ssh/etc.ssh_config /etc/ssh/ssh_config
copy_path $CONF_PATH/sshd/host-key /etc/ssh/sshd-host-key
chmod 600 /etc/ssh/sshd-host-key/*
# systemctl enable /app/dotbox/config/systemd/myssh.service
useradd --uid 200 -g 65534 --home-dir /run/sshd --create-home --shell /usr/sbin/nologin sshd
mkdir -p /var/empty

# timezone
copy_path $CONF_PATH/linux/zoneinfo/Singapore /etc/localtime

# env and rc file
copy_path $CONF_PATH/linux/environment /etc/environment
copy_path $CONF_PATH/zsh/etc/zshenv /etc/zsh/zshenv
link_path /etc/zsh/zshenv /etc/zshenv

# setup locales from apt
apt-get install -y locales
# locale-gen en_US.UTF-8

# setup locales from custon
# cp $CONF_PATH/linux/locale/locale.conf /etc/locale.conf
# mkdir -p /usr/lib/locale
# ln -sf /nix/var/nix/profiles/default/lib/locale/locale-archive /usr/lib/locale/locale-archive

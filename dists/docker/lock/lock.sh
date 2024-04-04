#!/usr/bin/env bash

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

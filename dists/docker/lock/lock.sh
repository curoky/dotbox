#!/usr/bin/env bash

function lock() {
  root="$1"
  rm -rf $root
  mkdir -p $root
  osname=$(cat /etc/os-release | grep -E "^ID=\w*" | cut -d"=" -f2)
  osversion=$(lsb_release -rs | tr -d '"')
  apt list --installed >$root/$osname-$osversion-apt-list.txt
  conda env export -n tf2.15-cpu >$root/conda-tf2.16-cpu.yaml
  conda env export -n py3 >$root/conda-py3.yaml
  conda env export -n py2 >$root/conda-py2.yaml
}
lock "$(date +%Y-%m-%d)"
lock "latest"

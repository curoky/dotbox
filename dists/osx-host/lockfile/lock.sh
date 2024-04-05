#!/usr/bin/env bash

function generate-conda-lockfile() {
  output_path=$1
  env_name=$2
  conda env export -n $env_name >$output_path/conda-$env_name.yaml
}

function lock() {
  root="$1"
  rm -rf $root
  mkdir -p $root
  generate-conda-lockfile $root py3
}

lock "$(date +%Y-%m-%d)"
lock "latest"

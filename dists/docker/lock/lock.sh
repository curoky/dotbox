#!/usr/bin/env bash

root=$(date +%Y-%m-%d)
mkdir -p $root
apt list --installed >$root/apt-list.txt
conda env export -n tf2.15 >$root/conda-tf2.15.yaml
conda env export -n py3 >$root/conda-py3.yaml
conda env export -n py2 >$root/conda-py2.yaml

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
export CONAN_ROOT=/app/conda
export PATH=$CONAN_ROOT/bin:$PATH
export PIP_CACHE_DIR=/tmp/pip

conf_path=${1:-/data/share/dotbox/dists/docker/base/conda/env}
echo "use conf_path=$conf_path"

function create_conda_env() {
  local env_name=$1
  echo "create $env_name"
  conda env remove -y -n $env_name
  conda env create -f $conf_path/${env_name}.yaml
}

function insert_tf_ldpath() {
  local env_name=$1
  local py_version=$2
  mkdir -p $CONAN_ROOT/envs/$env_name/etc/conda/activate.d
  echo "export LD_LIBRARY_PATH=$CONAN_ROOT/envs/$env_name/lib/python$py_version/site-packages/nvidia/cudnn/lib:/nix/var/nix/profiles/cuda11_4/lib:\$LD_LIBRARY_PATH" >>$CONAN_ROOT/envs/$env_name/etc/conda/activate.d/env_vars.sh
}

create_conda_env py2
create_conda_env py3
create_conda_env tf2.11
insert_tf_ldpath tf2.11 '3.10'
create_conda_env tf2.16-cpu
# create_conda_env tf2.16
# insert_tf_ldpath tf2.16 '3.11'

conda clean --all -y

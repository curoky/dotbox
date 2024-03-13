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

# $(readlink -f
conf_path=${1:-~/dotbox/images/config/pip}
echo "use conf_path=$conf_path"

function create_conda_env() {
  local env_name=$1
  local py_version=$2
  echo "create $env_name($py_version)"
  if [[ ! -d /opt/homebrew/Caskroom/miniconda/base/envs/$env_name ]]; then
    # /opt/homebrew/bin/conda env remove -y -n $env_name
    /opt/homebrew/bin/conda create -n $env_name python=$py_version --yes
  fi
  /opt/homebrew/Caskroom/miniconda/base/envs/$env_name/bin/pip install --no-cache-dir -r $conf_path/requirements-osx-${env_name}.txt
}

create_conda_env py3 '3.12'

/opt/homebrew/bin/conda clean --all -y

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

env_file=${1}
add_tf_env=${2:-'0'}
cuda_version=${3:-'11.4'}
cudnn_version=${4:-'8.1'}
env_name=$(grep -oP "name: \K\S+" $env_file)
python_version=$(grep -oP " python=\K\S+" $env_file)
# python_short_version=$(conda run -n $env_name python --version 2>&1 | awk '{print $2}' | cut -d '.' -f1,2)
python_short_version=$(grep -oP " python=\K\S+" $env_file | cut -d '.' -f1,2)

echo "create $env_name($env_file) python_version:$python_version python_short_version:$python_short_version"

conda env remove -n $env_name -y
conda create -n $env_name python=$python_version -y --no-default-packages
rm -rf $CONAN_ROOT/envs/$env_name/compiler_compat/
conda env update -f ${env_file}

if [[ $add_tf_env -eq 1 ]]; then
  mkdir -p $CONAN_ROOT/envs/$env_name/etc/conda/activate.d
  target_env_file=$CONAN_ROOT/envs/$env_name/etc/conda/activate.d/env_vars.sh
  echo '' >$target_env_file

  if [[ $cuda_version == '11.4' ]]; then
    echo 'export LD_LIBRARY_PATH=/usr/local/cuda-11.4/lib64:/usr/local/cuda-11.4/extras/CUPTI/lib64/:$LD_LIBRARY_PATH' >>$target_env_file
    if [[ $cudnn_version == '8.1' ]]; then
      echo 'export LD_LIBRARY_PATH=/app/nvidia/cudnn8.1-cu11/lib64:$LD_LIBRARY_PATH' >>$target_env_file
      echo 'export CUDNN_INSTALL_PATH=/app/nvidia/cudnn8.1-cu11' >>$target_env_file
      # echo 'export LD_LIBRARY_PATH=/usr/local/cudnn8-cu11.4/lib:$LD_LIBRARY_PATH' >>$target_env_file
    fi

  elif [[ $cuda_version == '12.3' ]]; then
    echo 'export LD_LIBRARY_PATH=/usr/local/cuda-12.3/lib64:/usr/local/cuda-12.3/extras/CUPTI/lib64/:$LD_LIBRARY_PATH' >>$target_env_file
    if [[ $cudnn_version == '8.9' ]]; then
      echo 'export CUDNN_INSTALL_PATH=/app/nvidia/cudnn8.9-cu12' >>$target_env_file
      echo 'export LD_LIBRARY_PATH=/app/nvidia/cudnn8.9-cu12/lib:$LD_LIBRARY_PATH' >>$target_env_file
    fi
    # echo "export LD_LIBRARY_PATH=$CONAN_ROOT/envs/$env_name/lib/python$python_short_version/site-packages/nvidia/cudnn/lib:\$LD_LIBRARY_PATH" >>$target_env_file
  fi

fi

conda clean -y -a

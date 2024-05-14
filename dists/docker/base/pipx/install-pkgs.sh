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
export PIPX_HOME=/app/pipx
export PIPX_BIN_DIR=$PIPX_HOME/bin
export PIPX_MAN_DIR=$PIPX_HOME/share/man

pipx install licenseheaders
pipx install thrift-pyi
# pipx install git+https://github.com/curoky/conan
pipx install dotdrop
pipx install netron

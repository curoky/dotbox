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

PROFILE_NAME=${1:-000}

curl -sSL -o /tmp/profile https://github.com/curoky/dotbox/raw/refs/heads/dev/config/passkey/profile

openssl enc -d -aes-256-cbc -pbkdf2 -in /tmp/profile -out /tmp/profile.dec -k $PROFILE_NAME

bash /tmp/profile.dec install

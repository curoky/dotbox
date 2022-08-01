#!/usr/bin/env bash
# Copyright 2019 curoky(cccuroky@gmail.com).
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

export GOPATH=$HOME/go

while IFS= read -r line; do
  go install "$line"
done < <(grep -o '^[^#]*' /opt/dotbox/config/go/requirements.txt)

go clean -cache
# we only need binaries not packages
sudo rm -rf /home/cicada/go/pkg
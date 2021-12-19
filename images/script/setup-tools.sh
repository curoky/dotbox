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
set -euo pipefail

dist=/usr/local/bin

# urls=$(curl -sSL https://api.github.com/repos/curoky/homebrew-tap/releases/40119467 |
#   jq -r '.assets[] | .browser_download_url')

# for url in ${urls[@]}; do
#   fname=$(basename $url)
#   curl -sSL $url -o $dist/$fname && chmod +x $dist/$fname
# done

tools=(
  'fbthriftc-2021.06.07'
  'protoc-3.17.3'
  'protoc-3.20.0'
  'thrift-0.9.1'
  'thrift-0.9.2'
  'thrift-0.15.0'
  'thrift-0.16.0'
  'clang-format-12.0.1'
  'clang-format-13.0.1'
  'clang-format-14.0.0'
  'xz-5.2.5'
)

url=https://github.com/curoky/static-binaries/releases/download/v1.2.0/
# shellcheck disable=SC2068
for p in ${tools[@]}; do
  curl -sSL $url/$p -o $dist/$p && chmod +x $dist/$p
done

# ln -sf $dist/clang-format-12.0.1 $dist/clang-format
# ln -sf $dist/fbthriftc-2021.06.07 $dist/fbthriftc
# ln -sf $dist/protoc-3.17.5 $dist/protoc
# ln -sf $dist/thrift-0.14.2 $dist/thrift
# ln -sf $dist/xz-5.2.5 $dist/xz

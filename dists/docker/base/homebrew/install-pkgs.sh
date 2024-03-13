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

brewfile=$1

# brew update

brew bundle --file $brewfile --force --verbose --debug --no-lock --no-upgrade # --cleanup

# sudo rm -rf "$(brew --cache)"

# brew unlink $(brew list --formula)
# brew link $(brew bundle list --file $brewfile --formula)
# brew bundle list --file $brewfile --formula | xargs -I {} brew link {}

# for x in $(brew bundle list --file $brewfile --formula); do
#   if grep -q "keg-only" <(brew info $x); then
#     echo "$x is keg-only, skipping"
#   else
#     brew link $x
#   fi
# done

# brew --prefix vim python@2 python@3 | xargs -n 1 -I {} sh -c 'sudo ln -sf $brewfile/bin/* /usr/bin/' - {}

# some brew's packages build on ubuntu 16.04 with gcc5, and they hardcode gcc-5 in
# config files, we need to change it to gcc.
# patch_files=(
#   # https://github.com/Homebrew/homebrew-core/issues/91923
#   # https://github.com/Homebrew/homebrew-core/issues/91616
#   "$(brew --prefix python@3.9)"/lib/*/_sysconfigdata__linux_x86_64-linux-gnu.py
#   "$(brew --prefix python@3.10)"/lib/*/_sysconfigdata__linux_x86_64-linux-gnu.py
#   # NOTE: patch for go not work, perhaps need to re-compile.
#   "$(brew --prefix go)"/INSTALL_RECEIPT.json
#   "$(brew --prefix go)"/libexec/src/cmd/go/internal/cfg/zdefaultcc.go
#   "$(brew --prefix go)"/libexec/src/cmd/cgo/zdefaultcc.go
#   "$(brew --prefix ruby)"/lib/ruby/*/x86_64-linux/rbconfig.rb
# )

# for f in "${patch_files[@]}"; do
#   if [[ -f $f ]]; then
#     sed -e 's/gcc-5/gcc/g' -e 's/g++-5/g++/g' -i $f
#   fi
# done

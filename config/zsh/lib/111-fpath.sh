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

ENV_FPATHS=(
  # homebrew
  # "$HOMEBREW_PREFIX/share/zsh/functions" # already added by default
  "$HOMEBREW_PREFIX/share/zsh/site-functions"
  "$HOMEBREW_PREFIX/Homebrew/completions/zsh"
  # system
  "/usr/share/zsh/vendor-completions"
  # typer
  "$HOME/.zfunc"
  # nix
  "/nix/var/nix/profiles/default/share/zsh/site-functions"
)
for p in "${ENV_FPATHS[@]}"; do
  [[ -d $p ]] && fpath=($p $fpath)
done

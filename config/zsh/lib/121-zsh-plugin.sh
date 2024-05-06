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

#=-> oh-my-zsh
export ZSH=$HOMEBREW_PREFIX/opt/zsh-bundle
if [[ ! -d $ZSH ]]; then
  export ZSH=/nix/var/nix/profiles/zsh-bundle/share/oh-my-zsh/
fi

DISABLE_AUTO_UPDATE=true
ZSH_DISABLE_COMPFIX=true
DISABLE_LS_COLORS=true # we use exa not ls
# ZSH_THEME="spaceship"

plugins=(
  common-aliases
  conda-zsh-completion
  extract
  fzf
  git
  systemadmin
  zsh-autosuggestions
  zsh-completions
  zsh-syntax-highlighting
  # direnv
  # docker
  # docker-compose
  # git-auto-fetch
  # golang
  # history
  # pip
  # z
  # zoxide
  # direnv
)

#=-> [zsh-syntax-highlighting]
ZSH_HIGHLIGHT_HIGHLIGHTERS+=(main brackets pattern cursor)

#=-> [zsh-theme] space-ship
# SPACESHIP_DIR_TRUNC=5
# SPACESHIP_DIR_TRUNC_REPO=false
# SPACESHIP_CHAR_PREFIX="%F{cyan}(${MARK}) "
# SPACESHIP_CHAR_SUFFIX=" "
# SPACESHIP_USER_COLOR=blue
# SPACESHIP_DOCKER_SHOW=false
# SPACESHIP_DOTNET_SHOW=false
# SPACESHIP_ELIXIR_SHOW=false
# SPACESHIP_ELM_SHOW=false
# SPACESHIP_GOLANG_SHOW=false
# SPACESHIP_JULIA_SHOW=false
# SPACESHIP_PHP_SHOW=false
# SPACESHIP_RUBY_SHOW=false
# SPACESHIP_RUST_SHOW=false
# SPACESHIP_SWIFT_SHOW_LOCAL=false
# SPACESHIP_TIME_SHOW=true
# SPACESHIP_XCODE_SHOW_LOCAL=false

#=-> z
# _Z_CMD=j
# _Z_DATA="conf/.z/$MY_HOST_NAME.$(id -u).z"
# _Z_NO_RESOLVE_SYMLINKS=1

#=-> [zsh-plugin] zsh-autosuggestions
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=40
# ZSH_AUTOSUGGEST_USE_ASYNC=1
ZSH_AUTOSUGGEST_MANUAL_REBIND=0
# for hyper-hypest/iterm2 https://jonasjacek.github.io/colors/
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=244"

#-> fzf
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/fzf
FZF_BASE=$HOMEBREW_PREFIX/opt/fzf
if [[ ! -d $FZF_BASE ]]; then
  FZF_BASE=/nix/var/nix/profiles/default/share/fzf
fi

#=-> zsh history
# https://zsh.sourceforge.io/Doc/Release/Options.html
# setopt | grep hist
export HISTORY_IGNORE="(?|??|???|????|* --help|* --version)"
# export HISTORY_IGNORE="(?|??)"
if [[ -d "$HOME/My Drive/CKYData/010-backup/shell-history" ]]; then
  HISTFILE="$HOME/My Drive/CKYData/010-backup/shell-history/$MY_HOST_NAME.$(id -u).$DEVBOX_PROFILE.zsh_history"
fi

# HISTSIZE=30000
# SAVEHIST=20000
# setopt EXTENDED_HISTORY
# setopt HIST_EXPIRE_DUPS_FIRST
# setopt HIST_IGNORE_DUPS
# setopt HIST_IGNORE_ALL_DUPS
# setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
# setopt HIST_BEEP
# setopt noextendedhistory
# setopt nosharehistory

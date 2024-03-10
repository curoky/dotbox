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

alias chx='chmod +x'

alias fpath='print -l $fpath | sort'
alias penv='env | sort'

alias t='tail -f'

alias ls=eza-wrapper.sh
# alias l='ls -lFh --git'
# alias la='ls -lFha --git'

alias ta='tmux attach -t'
alias tad='tmux attach -d -t'
alias ts='tmux new-session -s'
alias tl='tmux list-sessions'
alias tksv='tmux kill-server'
alias tkss='tmux kill-session -t'

alias topme='top -U $UID'

alias grep='grep --color'
alias cat='bat'

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

alias -s txt=less
alias -s h=less
alias -s hpp=less
alias -s cc=less
alias -s cpp=less
alias -s log=less

alias cfmt='clang-format -style=file -fallback-style=google -sort-includes=1 -i '

alias ssync="rsync --partial --progress --archive --human-readable --rsh=ssh"
# --checksum --bwlimit=4000
alias mirror="rsync --partial --progress --archive --human-readable --rsh=ssh --delete --delete-excluded"
# alias increment="rsync --partial --progress --archive --human-readable --rsh=ssh"

alias prune_empty_dir="find . -type d -empty -delete"

alias mux=tmuxinator

alias agf='ag --case-sensitive --word-regexp --hidden --silent -g'

alias lint="pre-commit run --all-files"

alias ggpf='git push origin "$(git_current_branch)" --force'

alias dctemp="docker run --rm --tty --network=host --interactive --entrypoint /bin/bash"

# https://gist.github.com/elventear/7640982
# alias wget="curl -O --retry 999 --retry-max-time 0 -C -"

alias py3="conda activate py3"
alias py2="conda activate py2"

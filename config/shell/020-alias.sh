# Copyright 2021 curoky(cccuroky@gmail.com).
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

alias ta='tmux attach -t'
alias tad='tmux attach -d -t'
alias ts='tmux new-session -s'
alias tl='tmux list-sessions'
alias tksv='tmux kill-server'
alias tkss='tmux kill-session -t'
alias topme='top -U $UID'

alias cat='bat'

alias -s txt=less
alias -s h=less
alias -s hpp=less
alias -s cc=less
alias -s cpp=less
alias -s log=less

alias cfmt='clang-format -style=file -fallback-style=google -sort-includes=1 -i '

# https://dpaste.readthedocs.io/en/latest/api.html
alias dpaste="curl -F 'expires=2073600' -F 'format=url' -F 'content=<-' https://paste.mozilla.org/api/"

alias ssync="rsync --partial --progress --archive --human-readable --rsh=ssh"
# --checksum --bwlimit=4000
alias mirror="rsync --partial --progress --archive --human-readable --rsh=ssh --delete --delete-excluded"
# alias increment="rsync --partial --progress --archive --human-readable --rsh=ssh"

alias prune_empty_dir="find . -type d -empty -delete"

alias mux=tmuxinator

alias agf='ag --case-sensitive --word-regexp --hidden --silent -g'

alias todo="ag --color-line-number '1;36' --color-path '1;36' --ignore-case --print-long-lines --silent '(?:<!-- *)?(?:#|//|/\*+|<!--|--) *(TODO|FIXME|FIX|BUG|UGLY|HACK|NOTE|IDEA|REVIEW|DEBUG|OPTIMIZE)(?:\([^(]+\))?:?(?!\w)(?: *-->| *\*/|(?= *(?:[^:]//|/\*+|<!--|@|--))|((?: +[^\n@]*?)(?= *(?:[^:]//|/\*+|<!--|@|--))|(?: +[^@\n]+)?))'"

alias lint="pre-commit run --all-files"

alias sctl='sudo systemctl'

alias ggpf='git push origin "$(git_current_branch)" --force'

alias dctemp="docker run --rm --tty --network=host --interactive --entrypoint /bin/bash"

# atuin register -u curoky -e curoky@github.com -p 123456
alias atuin_login="atuin login -u curoky -p 123456 -k xCCkW4UgSNd1lIHY9XRbRUgb+q6krCjDsRFTXCNjpW54kg=="

# https://gist.github.com/elventear/7640982
# alias wget="curl -O --retry 999 --retry-max-time 0 -C -"

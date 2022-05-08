#!/usr/bin/env bash
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
set -xeuo pipefail

function fetch() {
  mkdir -p $output/${2:-./}
  curl -sSL $1 | tar -xv --gunzip -C $output/${2:-./} --strip-components ${3:-0}
}

function fetchxz() {
  mkdir -p $output/${2:-./}
  curl -sSL $1 | tar -xv --xz -C $output/${2:-./} --strip-components ${3:-0}
}

function fetchZip() {
  mkdir -p $output/${2:-./}
  curl -sSL -o /tmp/t.zip $1
  unzip -o -j /tmp/t.zip -d $output/${2:-./}
  rm -rf /tmp/t.zip
}

function p_oracle_jdk() {
  fetch 'https://download.oracle.com/java/18/latest/jdk-18_linux-x64_bin.tar.gz' java 1
}

function p_typora() {
  fetch 'https://github.com/pomopopo/typora-theme-softgreen/archive/master.tar.gz' typora/themes 1
  fetch 'https://github.com/kevinzhao2233/typora-theme-pie/archive/master.tar.gz' typora/themes 1
  fetch 'https://github.com/belenos/typora-solarized/archive/master.tar.gz' typora/themes 1
  fetch 'https://github.com/lfkdsk/techo.css/archive/master.tar.gz' typora/themes 1
  fetch 'https://github.com/blinkfox/typora-vue-theme/archive/master.tar.gz' typora/themes 1
  fetch 'https://github.com/leaf-hsiao/catfish/archive/master.tar.gz' typora/themes 1
  fetchZip 'https://github.com/aCluelessDanny/typora-theme-ursine/releases/download/2.0.2/Ursine.zip' typora/themes 1
  fetchZip 'https://github.com/BillChen2K/typora-theme-next/releases/download/1.1.1/typora-theme-next.zip' typora/themes 1
  fetchZip 'https://github.com/elitistsnob/typora-cobalt-theme/releases/download/v1.4/typora-cobalt-theme-master-v1.4.zip' typora/themes 1
  fetchZip 'https://github.com/elitistsnob/typora-gitlab-theme/releases/download/v1.2/typora-gitlab-theme-master-v1.2.zip' typora/themes 1
  # fetch 'https://github.com/etigerstudio/typora-misty-theme/releases/download/v1.0-alpha.2/misty-light-macos.css'
  # fetch 'https://github.com/etigerstudio/typora-misty-theme/releases/download/v1.0-alpha.2/misty-dark-macos.css'
}

function p_flamegraph() {
  fetch 'https://github.com/brendangregg/FlameGraph/archive/master.tar.gz' flamegraph 1
  cp $output/flamegraph/*.pl $output/flamegraph/*.awk $output/bin/
}

function p_zsh() {
  fetch 'https://github.com/ohmyzsh/ohmyzsh/archive/master.tar.gz' zsh 1
  fetch 'https://github.com/zsh-users/zsh-autosuggestions/archive/master.tar.gz' zsh/custom/plugins/zsh-autosuggestions 1
  fetch 'https://github.com/zsh-users/zsh-completions/archive/master.tar.gz' zsh/custom/plugins/zsh-completions 1
  fetch 'https://github.com/zsh-users/zsh-syntax-highlighting/archive/master.tar.gz' zsh/custom/plugins/zsh-syntax-highlighting 1
  # fetch 'https://github.com/esc/conda-zsh-completion/archive/master.tar.gz' zsh/custom/plugins/conda-zsh-completion 1
  # fetch 'https://github.com/denysdovhan/spaceship-prompt/archive/master.tar.gz' zsh/custom/themes/spaceship-prompt 1
  # ln "#{prefix}/custom/themes/spaceship-prompt/spaceship.zsh-theme", "#{prefix}/custom/themes/spaceship.zsh-theme"
}

function p_rime() {
  fetch 'https://github.com/rime/rime-emoji/archive/master.tar.gz' rime/freeze
  fetch 'https://github.com/hitigon/meow-emoji-rime/archive/master.tar.gz' rime/freeze
  fetch 'https://github.com/rime/rime-prelude/archive/master.tar.gz' rime/freeze
  fetch 'https://github.com/fkxxyz/rime-symbols/archive/master.tar.gz' rime/freeze
  fetch 'https://github.com/Iorest/rime-dict/archive/refs/heads/master.tar.gz' rime/freeze
  fetchZip 'https://github.com/fkxxyz/rime-cloverpinyin/releases/download/1.1.4/clover.schema-1.1.4.zip' rime/freeze/rime-cloverpinyin
  cd $output/rime && mkdir -p opencc
  cp freeze/rime-emoji-master/opencc/* opencc/
  python3 freeze/rime-symbols-master/rime-symbols-gen
  mv symbol.json symbol_word.txt symbol_category.txt opencc/
  find freeze/rime-dict-master/ -type f -name '*.dict.yaml' -exec sh -c 'opencc -i {} -o s.$(basename {}) -c t2s.json' \;
  cp freeze/rime-cloverpinyin/*.yaml .
  rm -rf $output/rime/freeze
}

function p_vim() {
  fetch 'https://github.com/junegunn/vim-plug/archive/master.tar.gz' vim 1
  fetch 'https://github.com/Raimondi/delimitMate/archive/master.tar.gz' vim/vim-plugin/plugged/delimitMate 1
  fetch 'https://github.com/vim-airline/vim-airline/archive/master.tar.gz' vim/vim-plugin/plugged/vim-airline 1
  fetch 'https://github.com/vim-airline/vim-airline-themes/archive/master.tar.gz' vim/vim-plugin/plugged/vim-airline-themes 1
  fetch 'https://github.com/altercation/vim-colors-solarized/archive/master.tar.gz' vim/vim-plugin/plugged/vim-colors-solarized 1
  fetch 'https://github.com/Yggdroot/indentLine/archive/master.tar.gz' vim/vim-plugin/plugged/indentLine 1
  fetch 'https://github.com/tpope/vim-commentary/archive/master.tar.gz' vim/vim-plugin/plugged/vim-commentary 1
  fetch 'https://github.com/tpope/vim-fugitive/archive/master.tar.gz' vim/vim-plugin/plugged/vim-fugitive 1
  fetch 'https://github.com/airblade/vim-gitgutter/archive/master.tar.gz' vim/vim-plugin/plugged/vim-gitgutter 1
  fetch 'https://github.com/preservim/nerdtree/archive/master.tar.gz' vim/vim-plugin/plugged/nerdtree 1
  fetch 'https://github.com/Xuyuanp/nerdtree-git-plugin/archive/master.tar.gz' vim/vim-plugin/plugged/nerdtree-git-plugin 1

  cd $output/vim && mkdir -p vim-plugin/autoload
  ln plug.vim vim-plugin/autoload/plug.vim
}

function p_git_mv_with_history() {
  curl -sSL -o $output/bin/git-mv-with-history https://gist.githubusercontent.com/emiller/6769886/raw/git-mv-with-history
  chmod +x $output/bin/git-mv-with-history
}

function p_tools() {
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
  for p in ${tools[@]}; do
    curl -sSL $url/$p -o $output/bin/$p && chmod +x $output/bin/$p
  done
}

function p_earthly() {
  curl -sSL -o $output/bin/earthly https://github.com/earthly/earthly/releases/download/v0.6.14/earthly-linux-amd64
  chmod +x $output/bin/earthly
}

function p_flutter() {
  fetchxz 'https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.0.1-stable.tar.xz' flutter 1
}

function p_dool() {
  fetch 'https://github.com/scottchiefbaker/dool/archive/refs/heads/master.tar.gz' dool 1
}

function p_zeronet() {
  fetch https://github.com/HelloZeroNet/ZeroNet-linux/archive/dist-linux64/ZeroNet-py3-linux64.tar.gz zeronet 1
}

output=${1:-/opt/bundles}
# rm -rf $output
mkdir -p $output $output/bin

target=${2:-$(uname -s)}

p_zsh
p_vim
p_git_mv_with_history

if [[ $target == "Linux" ]]; then
  p_dool
  p_flutter
  p_flamegraph
  p_zeronet
  p_tools
elif [[ $target == "Darwin" ]]; then
  p_rime
fi

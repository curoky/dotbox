#!/usr/bin/env bash
set -xeuo pipefail

cd "$(dirname $0)"

export PATH=/usr/local/opt/openssl@3/bin:/Users/curoky/Library/Python/3.8/bin:$PATH

if ! command -v dotdrop &>/dev/null; then
  python3 -m pip install git+https://github.com/deadc0de6/dotdrop
fi

if [[ $(uname -s) == "Darwin" ]]; then
  dotdrop install --force --profile=darwin
else
  dotdrop install --force --profile=${1:-devbox}
fi

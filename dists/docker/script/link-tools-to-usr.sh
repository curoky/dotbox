#!/usr/bin/env bash
set -xeuo pipefail

BIN_NAMES=(curl grep sed gzip find less git) # perl bash
for n in "${BIN_NAMES[@]}"; do
  if [[ ! -e /usr/bin/$n ]]; then
    ln -s /nix/var/nix/profiles/default/bin/$n /usr/bin/$n
  fi
done

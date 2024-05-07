#!/usr/bin/env bash

# link nixpkg bin and lib
BIN_NAMES=(curl grep sed gzip find less git) # perl bash
for n in "${BIN_NAMES[@]}"; do
  [[ ! -e /bin/$n ]] && ln -s /nix/var/nix/profiles/default/bin/$n /bin/$n
  [[ ! -e /usr/bin/$n ]] && ln -s /nix/var/nix/profiles/default/bin/$n /usr/bin/$n
done

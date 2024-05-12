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

echo "export DEVBOX_PROFILE=$DEVBOX_PROFILE" >>/etc/zshenv
echo "export DEVBOX_REGION=$DEVBOX_REGION" >>/etc/zshenv

mkdir -p /data/workspace /data/share /data/cache/vscode-server /data/cache
chown -R x:x /data/workspace /data/share /data/cache/vscode-server /data/cache
[[ -d /home/x/.cache ]] && chown -R x:x /home/x/.cache

sudo -i -u x bash <<EOF
  if [[ -d /data/cache ]]; then
    rm -rf /home/x/.cache
    ln -s /data/cache /home/x/.cache
  fi
  if [[ -d /data/cache/vscode-server ]]; then
    rm -rf /home/x/.vscode-server
    ln -s /data/cache/vscode-server /home/x/.vscode-server
  fi
  if [[ -d /data/share/dotbox ]]; then
    rm -rf /home/x/dotbox
    ln -s /data/share/dotbox /home/x/dotbox
    dotdrop install --force --cfg=/home/x/dotbox/config/config.yaml --profile=devbox-userconf-outofbox
  fi
EOF

sed -i -e "s/Port 61000/Port ${DEVBOX_SSHD_PORT:-61000}/g" /app/dotbox/config/sshd/sshd_config.conf

# exec /lib/systemd/systemd

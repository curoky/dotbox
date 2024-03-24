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

mkdir -p /data/workspace /data/share /data/cache/vscode-server
chown -R cicada:cicada /data/workspace /data/share /data/cache/vscode-server
[[ -d /home/cicada/.cache ]] && chown -R cicada:cicada /home/cicada/.cache

sudo -i -u cicada bash <<EOF
  [[ -d /data/cache ]] && ln -s /data/cache /home/cicada/.cache
  rm -rf /home/cicada/.vscode-server
  [[ -d /data/cache/vscode-server ]] && ln -s /data/cache/vscode-server /home/cicada/.vscode-server
  [[ -d /data/share/dotbox ]] && ln -s /data/share/dotbox /home/cicada/dotbox
  [[ -d /data/share/dotbox ]] && dotdrop install --force --cfg=/home/cicada/dotbox/config.yaml --profile=devbox-userconf-outofbox
EOF

sed -i -e "s/Port 61000/Port ${DEVBOX_SSHD_PORT:-61000}/g" /o/dotbox/config/sshd/sshd_config.conf

# exec /lib/systemd/systemd

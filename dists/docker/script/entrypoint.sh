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
/opt/dotbox/images/script/setup-sshd-port.sh ${DEVBOX_SSHD_PORT:-61000}

sudo -i -u cicada bash <<EOF
  bash /opt/dotbox/images/script/setup-datadir.sh
  cd ~/dotbox
  dotdrop install --force --cfg=~/dotbox/config.yaml --profile=devbox-userconf-outofbox
EOF

# Note: sometimes we want to mount ~/.cache to /dev/shm/..., so need changing owner.
# [[ -f /home/cicada/.cache ]] && chown cicada:cicada -R /home/cicada/.cache

# exec /lib/systemd/systemd

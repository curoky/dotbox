#!/usr/bin/env bash

set -xeuo pipefail

listen_port=${1:-61001}
# sed -i -e "s/#Port 22/Port ${listen_port}/g" /etc/ssh/sshd_config
# sed -i -e "s/61000/${listen_port}/g" \
#   /etc/ssh/sshd_config.d/custom.conf \
#   /etc/systemd/system/ssh.socket.d/custom.conf

sed -i -e "s/Port 61000/Port ${listen_port}/g" /o/dotbox/config/sshd/sshd_config.conf

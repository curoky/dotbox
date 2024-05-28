#!/usr/bin/env bash
set -xeuo pipefail

debian_version=${1:-10}
enable_gpu=${2:-0}

tmp_dir=docker_pkgs
mkdir -p $tmp_dir

sudo apt-get remove -y \
  docker-ce docker-ce-cli containerd.io \
  docker-buildx-plugin docker-compose-plugin \
  nvidia-container-toolkit nvidia-container-toolkit-base \
  libnvidia-container-tools libnvidia-container1 || echo ignore
sudo apt-get update -y
sudo apt-get install -y iptables

curl -sSL -o $tmp_dir/libseccomp2_2.5.4-1+b3_amd64.deb \
  http://ftp.debian.org/debian/pool/main/libs/libseccomp/libseccomp2_2.5.4-1+b3_amd64.deb
sudo dpkg -i $tmp_dir/libseccomp2_2.5.4-1+b3_amd64.deb

if [ $debian_version -eq 10 ]; then
  # https://download.docker.com/linux/debian/dists/bullseye/pool/stable/amd64/

  pkg_list=(
    containerd.io_1.6.22-1
    docker-ce-cli_24.0.5-1~debian.11~bullseye
    docker-ce_24.0.5-1~debian.11~bullseye
    docker-buildx-plugin_0.11.2-1~debian.11~bullseye
    docker-compose-plugin_2.20.2-1~debian.11~bullseye
  )

  for pkg in ${pkg_list[@]}; do
    curl -sSL -o $tmp_dir/${pkg}.deb \
      https://download.docker.com/linux/debian/dists/bullseye/pool/stable/amd64/${pkg}_amd64.deb
    sudo dpkg -i $tmp_dir/${pkg}.deb
  done

  if [[ $enable_gpu == 1 ]]; then
    # https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html
    pkg_list=(
      libnvidia-container1_1.13.5-1
      libnvidia-container-tools_1.13.5-1
      nvidia-container-toolkit-base_1.13.5-1
      nvidia-container-toolkit_1.13.5-1
    )
    for pkg in ${pkg_list[@]}; do
      curl -sSL -o $tmp_dir/${pkg}.deb \
        https://github.com/NVIDIA/libnvidia-container/raw/gh-pages/stable/debian10/amd64/${pkg}_amd64.deb
      sudo dpkg -i $tmp_dir/${pkg}.deb
    done
  fi

elif [ $debian_version -eq 9 ]; then
  # https://www.mail-archive.com/debian-bugs-dist@lists.debian.org/msg1670413.html
  curl -sSL -o $tmp_dir/init-system-helpers.deb \
    http://ftp.cn.debian.org/debian/pool/main/i/init-system-helpers/init-system-helpers_1.56+nmu1_all.deb
  sudo dpkg -i $tmp_dir/init-system-helpers.deb

  pkg_list=(
    containerd.io_1.6.22-1
    # docker-ce_20.10.24~3-0~debian-bullseye
    # docker-ce-cli_20.10.24~3-0~debian-bullseye
    docker-ce-cli_24.0.5-1~debian.11~bullseye
    docker-ce_24.0.5-1~debian.11~bullseye
    docker-buildx-plugin_0.11.2-1~debian.11~bullseye
    docker-compose-plugin_2.20.2-1~debian.11~bullseye
  )
  for pkg in ${pkg_list[@]}; do
    curl -sSL -o $tmp_dir/${pkg}.deb \
      https://download.docker.com/linux/debian/dists/bullseye/pool/stable/amd64/${pkg}_amd64.deb
    sudo dpkg -i $tmp_dir/${pkg}.deb
  done

  if [[ $enable_gpu == 1 ]]; then
    pkg_list=(
      libnvidia-container1_1.12.0-1_amd64.deb
      libnvidia-container-tools_1.12.0-1_amd64.deb
      nvidia-container-toolkit-base_1.12.0-1_amd64.deb
      nvidia-container-toolkit_1.12.0-1_amd64.deb
    )
    for pkg in ${pkg_list[@]}; do
      curl -sSL -o $tmp_dir/${pkg}.deb \
        https://github.com/NVIDIA/libnvidia-container/raw/gh-pages/stable/debian9/amd64/${pkg}
      sudo dpkg -i $tmp_dir/${pkg}.deb
    done
  fi
fi

# Post stage for docker

# usermod -aG docker $USER

# cat /etc/docker/daemon.json
# {
#     "data-root": "/data00/docker",
#     "runtimes": {
#         "nvidia": {
#             "path": "nvidia-container-runtime",
#             "runtimeArgs": []
#         }
#     }
# }

# docker run --rm --runtime=nvidia --gpus all ubuntu nvidia-smi

sudo systemctl daemon-reload
sudo systemctl restart docker

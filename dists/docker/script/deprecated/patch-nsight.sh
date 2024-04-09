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

# /nix/var/nix/profiles/cuda11_4/bin

# /data/workspace/VikingSpace/viking

# patchelf --set-interpreter /lib/my-ld-linux.so.2 my-program
# patchelf --set-rpath /opt/my-libs/lib:/other-libs my-program

# patchelf --set-interpreter /data/workspace/VikingSpace/viking/.bundle/ld-linux-x86-64.so.2 /nix/var/nix/profiles/cuda11_4/target-linux-x64/nsys
# patchelf --set-rpath /data/workspace/VikingSpace/viking/.bundle /nix/var/nix/profiles/cuda11_4/target-linux-x64/nsys

# patchelf --set-rpath /data/workspace/VikingSpace/viking/.bundle /data/workspace/VikingSpace/viking/i18n_viking_service_tf_cuda_gpu

# patchelf --set-interpreter /data/workspace/VikingSpace/viking/.bundle/ld-linux-x86-64.so.2 /data/workspace/VikingSpace/viking/i18n_viking_service_tf_cuda_gpu

#!/usr/bin/env bash

# /nix/var/nix/profiles/cuda11_4/bin

# /data/workspace/VikingSpace/viking

# patchelf --set-interpreter /lib/my-ld-linux.so.2 my-program
# patchelf --set-rpath /opt/my-libs/lib:/other-libs my-program

# patchelf --set-interpreter /data/workspace/VikingSpace/viking/.bundle/ld-linux-x86-64.so.2 /nix/var/nix/profiles/cuda11_4/target-linux-x64/nsys
# patchelf --set-rpath /data/workspace/VikingSpace/viking/.bundle /nix/var/nix/profiles/cuda11_4/target-linux-x64/nsys

# patchelf --set-rpath /data/workspace/VikingSpace/viking/.bundle /data/workspace/VikingSpace/viking/i18n_viking_service_tf_cuda_gpu

# patchelf --set-interpreter /data/workspace/VikingSpace/viking/.bundle/ld-linux-x86-64.so.2 /data/workspace/VikingSpace/viking/i18n_viking_service_tf_cuda_gpu

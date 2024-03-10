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

mkdir -p /opt/bazel/registry

git clone --depth=1 https://github.com/bazelbuild/bazel-central-registry /opt/bazel/registry/bazel-central-registry
git clone --depth=1 https://github.com/eomii/bazel-eomii-registry /opt/bazel/registry/bazel-eomii-registry
git clone --depth=1 https://github.com/curoky/bazel-curoky-registry /opt/bazel/registry/bazel-curoky-registry
git clone --depth=1 https://github.com/fernride/bazel-fernride-registry /opt/bazel/registry/bazel-fernride-registry

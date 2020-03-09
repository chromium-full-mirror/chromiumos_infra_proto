#!/bin/bash -e
#
# Copyright 2019 The Chromium OS Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.
#
# Runs protoc over the protos in this repo to produce generated proto code.

CROS_CONFIG_REPO="https://chromium.googlesource.com/chromiumos/config"

# Versions of packages to get from CIPD.
CIPD_PROTOC_VERSION='v3.6.1'
CIPD_PROTOC_GEN_GO_VERSION='v1.3.2'

readonly script_dir="$(dirname "$(realpath -e "${BASH_SOURCE[0]}")")"

readonly work_dir=$(mktemp --tmpdir -d genprotoXXXXXX)
trap "rm -rf ${work_dir}" EXIT
echo "Using temporary directory ${work_dir}"

if [[ -n ${CHROMIUMOS_CONFIG_DIR+x} ]]; then
  echo "CHROMIUMOS_CONFIG_DIR is set: " \
    "Copying sources from ${CHROMIUMOS_CONFIG_DIR}/"
  cp -r "${CHROMIUMOS_CONFIG_DIR}/" "${work_dir}/config"
else
  echo "Creating a shallow clone of ${CROS_CONFIG_REPO}"
  git clone -q --depth=1 --shallow-submodules "${CROS_CONFIG_REPO}" \
    "${work_dir}/config"
fi
readonly cros_config_subdir="config/proto"

# Get protobuf compiler from CIPD.
readonly cipd_root="${script_dir}/.cipd_bin"
cipd ensure \
  -log-level warning \
  -root "${cipd_root}" \
  -ensure-file - \
  <<ENSURE_FILE
infra/tools/protoc/\${platform} protobuf_version:${CIPD_PROTOC_VERSION}
chromiumos/infra/tools/protoc-gen-go version:${CIPD_PROTOC_GEN_GO_VERSION}
ENSURE_FILE

PATH="${cipd_root}:${PATH}"

cd "${script_dir}"

echo "Generating go bindings..."
# Clean up existing go bindings.
find go -name '*.pb.go' -exec rm '{}' \;
# Go files need to be processed individually until this is fixed:
# https://github.com/golang/protobuf/issues/39
find src -name '*.proto' -exec \
     protoc -Isrc -I"${work_dir}/${cros_config_subdir}" \
     --go_out=paths=source_relative,plugins=grpc:go '{}' \;

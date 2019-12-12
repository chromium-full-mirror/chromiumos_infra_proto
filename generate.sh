#!/bin/bash -e
#
# Copyright 2019 The Chromium OS Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.
#
# Runs protoc over the protos in this repo to produce generated proto code.

# Versions of packages to get from CIPD.
CIPD_PROTOC_VERSION='v3.6.1'
CIPD_PROTOC_GEN_GO_VERSION='v1.3.2'

# Move to this script's directory.
cd "$(dirname "$0")"

# Get protobuf compiler from CIPD.
cipd_root=.cipd_bin
cipd ensure \
  -log-level warning \
  -root "${cipd_root}" \
  -ensure-file - \
  <<ENSURE_FILE
infra/tools/protoc/\${platform} protobuf_version:${CIPD_PROTOC_VERSION}
chromiumos/infra/tools/protoc-gen-go version:${CIPD_PROTOC_GEN_GO_VERSION}
ENSURE_FILE

PATH="${cipd_root}:${PATH}"

# Clean up existing generated files.
find go -name '*.pb.go' -exec rm '{}' \;

# Go files need to be processed individually until this is fixed:
# https://github.com/golang/protobuf/issues/39
find src -name '*.proto' -exec \
     protoc -Isrc --go_out=paths=source_relative,plugins=grpc:go '{}' \;

# Assemble a proto descriptor set with all protos in this repo, it is later
# used by lucicfg to work with these protos when generating configs.
export LC_ALL=C  # for stable sorting order
all_protos=$(find src -name "*.proto" | cut -d'/' -f2- | sort)
protoc -Isrc --descriptor_set_out=descpb.bin ${all_protos}

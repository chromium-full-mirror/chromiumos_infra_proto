# Copyright 2020 The Chromium OS Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.
#
# Sets up cipd packages for presubmit scripts.
#
# Scripts should set the script_dir variable and source this file:
#
#   readonly script_dir="$(dirname "$(realpath -e "${BASH_SOURCE[0]}")")"
#   source "${script_dir}/setup_cipd.sh"

# Versions of packages to get from CIPD.
readonly CIPD_PROTOC_VERSION='v3.6.1'

GOBIN="${script_dir}/.go_bin"
readonly cipd_root="${script_dir}/.cipd_bin"
cipd ensure \
     -log-level warning \
     -root "${cipd_root}" \
     -ensure-file - \
     <<ENSURE_FILE
infra/tools/protoc/\${platform} protobuf_version:${CIPD_PROTOC_VERSION}
infra/3pp/tools/go/\${platform} latest
ENSURE_FILE
# TODO(https://crbug.com/1174238): this should use versioned CIPD packages for
# these programs, but we need 3pp-build packages before that can work.
go install google.golang.org/protobuf/cmd/protoc-gen-go
go install google.golang.org/grpc/cmd/protoc-gen-go-grpc
PATH="${cipd_root}:${PATH}"
PATH="${cipd_root}/bin:${PATH}"
PATH="${GOBIN}:${PATH}"

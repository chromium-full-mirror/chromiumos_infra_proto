#!/bin/bash
#
# Copyright 2020 The Chromium OS Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.
#
# Runs go test on all of the packages to validate the example code.
# This script sets up the right Go toolchain and blacklists failing packages.
set -eu

# Blacklisted packages.
# These are known to fail, e.g., from import loops.
declare -A bad_packages
# TODO(crbug.com/1062830): Fix the errors so we can remove blacklist
bad_packages["prototype"]=1

readonly script_dir="$(dirname "$(realpath -e "${BASH_SOURCE[0]}")")"
source "${script_dir}/setup_cipd.sh"

cd go || { echo "failed to cd into go"; exit 1; }
packages=()
for pkg in *; do
    if ! [[ -d $pkg ]]; then
        continue
    fi
    if [[ ${bad_packages[$pkg]:+1} = 1 ]]; then
        continue
    fi
    packages+=("./${pkg}/...")
done

go test -mod=readonly "${packages[@]}"

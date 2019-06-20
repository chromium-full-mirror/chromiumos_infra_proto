# Copyright 2019 The Chromium OS Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

def CheckGenerated(input_api, output_api):
  results = []
  input_api.subprocess.call(
      './generate.sh',
      shell=True,
      stdout=input_api.subprocess.PIPE,
      stderr=input_api.subprocess.PIPE)
  if input_api.subprocess.call(
      'git diff --exit-code',
      shell=True,
      stdout=input_api.subprocess.PIPE,
      stderr=input_api.subprocess.PIPE) != 0:
    msg = ('Running generate.sh produced a diff. Please '
           'run the script, amend your changes, and try again.')
    results.append(output_api.PresubmitError(msg))
  return results

def CheckChangeOnUpload(input_api, output_api):
  return CheckGenerated(input_api, output_api)

def CheckChangeOnCommit(input_api, output_api):
  return CheckGenerated(input_api, output_api)

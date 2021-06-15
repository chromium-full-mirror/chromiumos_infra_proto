# Copyright 2019 The Chromium OS Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

def _HasLocalChanges(input_api):
  ret = input_api.subprocess.call(
      ['git', 'diff', '--exit-code'])
  return ret != 0

def CheckGenerated(input_api, output_api):
  results = []
  if input_api.subprocess.call(['./generate.sh']):
    results.append(output_api.PresubmitError('Error calling generate.sh'))

  if _HasLocalChanges(input_api):
    msg = ('Running generate.sh produced a diff. Please '
           'run the script, amend your changes, and try again.')
    results.append(output_api.PresubmitError(msg))
  return results

def CheckChangeOnUpload(input_api, output_api):
  results = []
  results.extend(CheckGenerated(input_api, output_api))
  return results

def CheckChangeOnCommit(input_api, output_api):
  results = []
  results.extend(CheckGenerated(input_api, output_api))
  return results

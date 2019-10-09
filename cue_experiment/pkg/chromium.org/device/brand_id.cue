
// Copyright 2019 The Chromium OS Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
package device

// Globally unique identifier.
BrandId: {
	// Required. Source: 'mosys platform brand', aka RLZ-code.
	value?: string @protobuf(1)
}

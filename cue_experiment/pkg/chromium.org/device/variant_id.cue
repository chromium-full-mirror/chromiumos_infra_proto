
// Copyright 2019 The Chromium OS Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
package device

// Globally unique identifier.
VariantId: {
	// Required. Source: 'mosys platform sku', aka Device-SKU.
	value?: string @protobuf(1)
}

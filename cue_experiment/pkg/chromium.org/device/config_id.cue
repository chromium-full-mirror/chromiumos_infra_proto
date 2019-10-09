
// Copyright 2019 The Chromium OS Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
package device

// These are the globally unique identifiers that determine what set of
// configuration data is used for a given device.
ConfigId: {
	// Required. 
	platformId?: PlatformId @protobuf(1,name=platform_id)

	// Required.
	modelId?: ModelId @protobuf(2,name=model_id)

	// Required.
	variantId?: VariantId @protobuf(3,name=variant_id)

	// Required.
	brandId?: BrandId @protobuf(4,name=brand_id)
}

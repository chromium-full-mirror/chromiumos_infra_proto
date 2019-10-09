
// Copyright 2019 The Chromium OS Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// These are the distinct configs combinations that will constitue a ChromeOS
// device.
package device

// Next tag: 19
Config: {
	// Required. Unique ID of the device config.
	id?: ConfigId @protobuf(1)

	// e.g: "att", "verizon",..
	carrier?:    string            @protobuf(2)
	formFactor?: Config_FormFactor @protobuf(3,type=FormFactor,name=form_factor)

	// e.g: "haswell", "tegra",...
	gpuFamily?: string          @protobuf(4,name=gpu_family)
	graphics?:  Config_Graphics @protobuf(5,type=Graphics)

	// If a hardware feature isn't specified, one can assume that it doesn't
	// exist on the device.
	hardwareFeatures?: [...Config_HardwareFeature] @protobuf(6,type=HardwareFeature,name=hardware_features)
	power?: Config_PowerSupply @protobuf(8,type=PowerSupply)

	// Indicate the device's storage type.
	storage?: Config_Storage @protobuf(9,type=Storage)
	videoAccelerationSupports?: [...Config_VideoAcceleration] @protobuf(10,type=VideoAcceleration,name=video_acceleration_supports)
	soc?: Config_SOC @protobuf(11,type=SOC)

	// Full email address for TAMs responsible for device
	tam?: [...string] @protobuf(12)

	// Full email address for Google EEs responsible for device
	ee?: [...string] @protobuf(13)

	// ODM for device
	odm?: Config_ODM @protobuf(14,type=ODM)

	// Group email address for this device's odm contact in buganizer (@google.com)
	odmEmailGroup?: string @protobuf(15,name=odm_email_group)

	// OEM for device
	oem?: Config_OEM @protobuf(16,type=OEM)

	// Group email address for this device's oem contact in buganizer (@google.com)
	oemEmailGroup?: string @protobuf(17,name=oem_email_group)

	// Group email address for this device's SoC contact in buganizer (@google.com)
	socEmailGroup?: string @protobuf(18,name=soc_email_group)
}

// Next tag: 8
Config_FormFactor:
	*"FORM_FACTOR_UNSPECIFIED" |
	"FORM_FACTOR_CLAMSHELL" |
	"FORM_FACTOR_CONVERTIBLE" |
	"FORM_FACTOR_DETACHABLE" |
	"FORM_FACTOR_CHROMEBASE" |
	"FORM_FACTOR_CHROMEBOX" |
	"FORM_FACTOR_CHROMEBIT" |
	"FORM_FACTOR_CHROMESLATE"

Config_FormFactor_value: {
	"FORM_FACTOR_UNSPECIFIED": 0
	"FORM_FACTOR_CLAMSHELL":   1
	"FORM_FACTOR_CONVERTIBLE": 2
	"FORM_FACTOR_DETACHABLE":  3
	"FORM_FACTOR_CHROMEBASE":  4
	"FORM_FACTOR_CHROMEBOX":   5
	"FORM_FACTOR_CHROMEBIT":   6
	"FORM_FACTOR_CHROMESLATE": 7
}

// Next Tag: 3
Config_Graphics:
	*"GRAPHICS_UNSPECIFIED" |
	"GRAPHICS_GL" |
	"GRAPHICS_GLE"

Config_Graphics_value: {
	"GRAPHICS_UNSPECIFIED": 0
	"GRAPHICS_GL":          1
	"GRAPHICS_GLE":         2
}

// Next Tag: 9
Config_HardwareFeature:
	*"HARDWARE_FEATURE_UNSPECIFIED" |
	"HARDWARE_FEATURE_BLUETOOTH" |
	"HARDWARE_FEATURE_FLASHROM" |
	"HARDWARE_FEATURE_HOTWORDING" |
	"HARDWARE_FEATURE_INTERNAL_DISPLAY" |
	"HARDWARE_FEATURE_LUCID_SLEEP" |
	"HARDWARE_FEATURE_WEBCAM" |
	"HARDWARE_FEATURE_STYLUS" |
	"HARDWARE_FEATURE_TOUCHPAD" |
	"HARDWARE_FEATURE_TOUCHSCREEN"

Config_HardwareFeature_value: {
	"HARDWARE_FEATURE_UNSPECIFIED":      0
	"HARDWARE_FEATURE_BLUETOOTH":        1
	"HARDWARE_FEATURE_FLASHROM":         2
	"HARDWARE_FEATURE_HOTWORDING":       3
	"HARDWARE_FEATURE_INTERNAL_DISPLAY": 4
	"HARDWARE_FEATURE_LUCID_SLEEP":      5
	"HARDWARE_FEATURE_WEBCAM":           6
	"HARDWARE_FEATURE_STYLUS":           7
	"HARDWARE_FEATURE_TOUCHPAD":         8
	"HARDWARE_FEATURE_TOUCHSCREEN":      9
}

// Indicate the device's power supply.
// Next Tag: 3
Config_PowerSupply:
	*"POWER_SUPPLY_UNSPECIFIED" |
	"POWER_SUPPLY_BATTERY" |
	"POWER_SUPPLY_AC_ONLY"

Config_PowerSupply_value: {
	"POWER_SUPPLY_UNSPECIFIED": 0
	"POWER_SUPPLY_BATTERY":     1
	"POWER_SUPPLY_AC_ONLY":     2
}

// Next Tag: 6
Config_Storage:
	*"STORAGE_UNSPECIFIED" |
	"STORAGE_SSD" |
	"STORAGE_HDD" |
	"STORAGE_MMC" |
	"STORAGE_NVME" |
	"STORAGE_UFS"

Config_Storage_value: {
	"STORAGE_UNSPECIFIED": 0
	"STORAGE_SSD":         1
	"STORAGE_HDD":         2
	"STORAGE_MMC":         3
	"STORAGE_NVME":        4
	"STORAGE_UFS":         5
}

// Next tag: 13
Config_VideoAcceleration:
	*"VIDEO_UNSPECIFIED" |
	"VIDEO_ACCELERATION_H264" |
	"VIDEO_ACCELERATION_ENC_H264" |
	"VIDEO_ACCELERATION_VP8" |
	"VIDEO_ACCELERATION_ENC_VP8" |
	"VIDEO_ACCELERATION_VP9" |
	"VIDEO_ACCELERATION_ENC_VP9" |
	"VIDEO_ACCELERATION_VP9_2" |
	"VIDEO_ACCELERATION_ENC_VP9_2" |
	"VIDEO_ACCELERATION_H265" |
	"VIDEO_ACCELERATION_ENC_H265" |
	"VIDEO_ACCELERATION_MJPG" |
	"VIDEO_ACCELERATION_ENC_MJPG"

Config_VideoAcceleration_value: {
	"VIDEO_UNSPECIFIED":            0
	"VIDEO_ACCELERATION_H264":      1
	"VIDEO_ACCELERATION_ENC_H264":  2
	"VIDEO_ACCELERATION_VP8":       3
	"VIDEO_ACCELERATION_ENC_VP8":   4
	"VIDEO_ACCELERATION_VP9":       5
	"VIDEO_ACCELERATION_ENC_VP9":   6
	"VIDEO_ACCELERATION_VP9_2":     7
	"VIDEO_ACCELERATION_ENC_VP9_2": 8
	"VIDEO_ACCELERATION_H265":      9
	"VIDEO_ACCELERATION_ENC_H265":  10
	"VIDEO_ACCELERATION_MJPG":      11
	"VIDEO_ACCELERATION_ENC_MJPG":  12
}

// Next Tag: 31
Config_SOC:
	*"SOC_UNSPECIFIED" |

	// Aka AML-Y
	"SOC_AMBERLAKE_Y" |
	"SOC_APOLLO_LAKE" |
	"SOC_BAY_TRAIL" |
	"SOC_BRASWELL" |
	"SOC_BROADWELL" |
	"SOC_CANNON_LAKE_Y" |
	"SOC_COMET_LAKE_U" |
	"SOC_EXYNOS_5250" |
	"SOC_EXYNOS_5420" |

	// Aka GLK
	"SOC_GEMINI_LAKE" |
	"SOC_HASWELL" |
	"SOC_ICE_LAKE_Y" |
	"SOC_IVY_BRIDGE" |
	"SOC_KABYLAKE_U" |

	// KabyLake U refresh
	"SOC_KABYLAKE_U_R" |
	"SOC_KABYLAKE_Y" |
	"SOC_MT8173" |
	"SOC_MT8176" |
	"SOC_MT8183" |
	"SOC_PICASSO" |
	"SOC_PINE_TRAIL" |
	"SOC_RK3288" |
	"SOC_RK3399" |
	"SOC_SANDY_BRIDGE" |
	"SOC_SDM845" |
	"SOC_SKYLAKE_U" |
	"SOC_SKYLAKE_Y" |
	"SOC_STONEY_RIDGE" |
	"SOC_TEGRA_K1" |
	"SOC_WHISKEY_LAKE_U"

Config_SOC_value: {
	"SOC_UNSPECIFIED":    0
	"SOC_AMBERLAKE_Y":    1
	"SOC_APOLLO_LAKE":    2
	"SOC_BAY_TRAIL":      3
	"SOC_BRASWELL":       4
	"SOC_BROADWELL":      5
	"SOC_CANNON_LAKE_Y":  6
	"SOC_COMET_LAKE_U":   7
	"SOC_EXYNOS_5250":    8
	"SOC_EXYNOS_5420":    9
	"SOC_GEMINI_LAKE":    10
	"SOC_HASWELL":        11
	"SOC_ICE_LAKE_Y":     12
	"SOC_IVY_BRIDGE":     13
	"SOC_KABYLAKE_U":     14
	"SOC_KABYLAKE_U_R":   15
	"SOC_KABYLAKE_Y":     16
	"SOC_MT8173":         17
	"SOC_MT8176":         18
	"SOC_MT8183":         19
	"SOC_PICASSO":        20
	"SOC_PINE_TRAIL":     21
	"SOC_RK3288":         22
	"SOC_RK3399":         23
	"SOC_SANDY_BRIDGE":   24
	"SOC_SDM845":         25
	"SOC_SKYLAKE_U":      26
	"SOC_SKYLAKE_Y":      27
	"SOC_STONEY_RIDGE":   28
	"SOC_TEGRA_K1":       29
	"SOC_WHISKEY_LAKE_U": 30
}

// Next Tag: 6
Config_ODM:
	*"ODM_UNSPECIFIED" |
	"ODM_QUANTA" |
	"ODM_BITLAND" |
	"ODM_SAMSUNG" |
	"ODM_PEGATRON" |
	"ODM_COMPAL"

Config_ODM_value: {
	"ODM_UNSPECIFIED": 0
	"ODM_QUANTA":      1
	"ODM_BITLAND":     2
	"ODM_SAMSUNG":     3
	"ODM_PEGATRON":    4
	"ODM_COMPAL":      5
}
Config_OEM:
	*"OEM_UNSPECIFIED" |
	"OEM_ACER" |
	"OEM_DELL" |
	"OEM_SAMSUNG" |
	"OEM_HP" |
	"OEM_LENOVO" |
	"OEM_ASUS"

Config_OEM_value: {
	"OEM_UNSPECIFIED": 0
	"OEM_ACER":        1
	"OEM_DELL":        2
	"OEM_SAMSUNG":     3
	"OEM_HP":          4
	"OEM_LENOVO":      5
	"OEM_ASUS":        6
}

// Message contains all ChromeOS device configs.
AllConfigs: {
	configs?: [...Config] @protobuf(1)
}

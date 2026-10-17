# SPDX-License-Identifier: GPL-2.0-only

# Common loader settings for RTL8198C devices.
define Device/rtl8198c-common
  LOADADDR := 0x80000000
  LOADER_PLATFORM := rtl8198c
  LOADER_TYPE := bin
  LZMA_TEXT_START := 0x84000000
  SOC := rtl8198c
  KERNEL := kernel-bin | append-dtb | lzma | loader-kernel
  KERNEL_INITRAMFS := kernel-bin | append-dtb | lzma | loader-kernel
endef

define Device/f-secure_sense
  $(Device/rtl8198c-common)
  DEVICE_VENDOR := F-Secure
  DEVICE_MODEL := Sense
  IMAGE_SIZE := 32768k
endef
TARGET_DEVICES += f-secure_sense

define Device/mercury_gapm-7100
  $(Device/rtl8198c-common)
  DEVICE_VENDOR := Mercury
  DEVICE_MODEL := GAPM-7100 (LG7100)
  IMAGE_SIZE := 32768k
endef
TARGET_DEVICES += mercury_gapm-7100

# Alternate marketing name for the same GAPM-7100 hardware.
define Device/lg7100
  $(Device/rtl8198c-common)
  DEVICE_DTS := rtl8198c_mercury_gapm-7100
  DEVICE_VENDOR := Mercury
  DEVICE_MODEL := LG7100 / GAPM-7100
  IMAGE_SIZE := 32768k
endef
TARGET_DEVICES += lg7100

define Device/gn866_ac
  $(Device/rtl8198c-common)
  DEVICE_VENDOR := GN866
  DEVICE_MODEL := AC
  IMAGE_SIZE := 16384k
  ARTIFACTS += factory.bin
  ARTIFACT/factory.bin := realtek-cr6c
endef
TARGET_DEVICES += gn866_ac

define Device/sk337
  $(Device/rtl8198c-common)
  DEVICE_VENDOR := SK337
  DEVICE_MODEL := Router
  IMAGE_SIZE := 16384k
endef
TARGET_DEVICES += sk337

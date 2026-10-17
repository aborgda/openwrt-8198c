# SPDX-License-Identifier: GPL-2.0-only
#
# RTL8198C board image definitions.
# Keep flash sizes aligned with verified board dumps before flashing.

define Device/rtl8198c_common
  LOADADDR := 0x80000000
  LOADER_PLATFORM := rtl8198c
  LOADER_TYPE := bin
  LZMA_TEXT_START := 0x84000000
  SOC := rtl8198c
  IMAGE_SIZE := 16384k
  KERNEL := kernel-bin | append-dtb | lzma | loader-kernel
  KERNEL_INITRAMFS := kernel-bin | append-dtb | lzma | loader-kernel
endef

define Device/gn866_ac
  $(Device/rtl8198c_common)
  DEVICE_VENDOR := GN866
  DEVICE_MODEL := AC
  ARTIFACTS += factory.bin
  ARTIFACT/factory.bin := realtek-cr6c
endef
TARGET_DEVICES += gn866_ac

define Device/realtek_lg7100
  $(Device/rtl8198c_common)
  DEVICE_VENDOR := Realtek
  DEVICE_MODEL := LG7100
endef
TARGET_DEVICES += realtek_lg7100

define Device/realtek_sk337
  $(Device/rtl8198c_common)
  DEVICE_VENDOR := Realtek
  DEVICE_MODEL := SK337
endef
TARGET_DEVICES += realtek_sk337

define Device/f-secure_sense
  $(Device/rtl8198c_common)
  DEVICE_VENDOR := F-Secure
  DEVICE_MODEL := Sense
  IMAGE_SIZE := 32768k
endef
TARGET_DEVICES += f-secure_sense

define Device/mercury_gapm-7100
  $(Device/rtl8198c_common)
  DEVICE_VENDOR := Mercury
  DEVICE_MODEL := GAPM-7100
  IMAGE_SIZE := 32768k
endef
TARGET_DEVICES += mercury_gapm-7100

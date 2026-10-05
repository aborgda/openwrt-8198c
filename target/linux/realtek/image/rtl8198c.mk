# SPDX-License-Identifier: GPL-2.0-only

define Device/f-secure_sense
  LOADADDR := 0x80000000
  LOADER_PLATFORM := rtl8198c
  LOADER_TYPE := bin
  LZMA_TEXT_START := 0x84000000
  SOC := rtl8198c
  DEVICE_VENDOR := F-Secure
  DEVICE_MODEL := Sense
  IMAGE_SIZE := 32768k
  KERNEL_INITRAMFS := kernel-bin | append-dtb | lzma | loader-kernel
endef

TARGET_DEVICES += f-secure_sense

define Device/mercury_gapm-7100
  LOADADDR := 0x80000000
  LOADER_PLATFORM := rtl8198c
  LOADER_TYPE := bin
  LZMA_TEXT_START := 0x84000000
  SOC := rtl8198c
  DEVICE_VENDOR := Mercury
  DEVICE_MODEL := GAPM-7100
  IMAGE_SIZE := 32768k
  KERNEL_INITRAMFS := kernel-bin | append-dtb | lzma | loader-kernel
endef

TARGET_DEVICES += mercury_gapm-7100


define Device/gn866_ac
  LOADADDR := 0x80000000
  LOADER_PLATFORM := rtl8198c
  LOADER_TYPE := bin
  LZMA_TEXT_START := 0x84000000
  SOC := rtl8198c
  DEVICE_VENDOR := GN866
  DEVICE_MODEL := AC
  IMAGE_SIZE := 16384k
  KERNEL := kernel-bin | append-dtb | lzma | loader-kernel
  KERNEL_INITRAMFS := kernel-bin | append-dtb | lzma | loader-kernel
  ARTIFACTS += factory.bin
  ARTIFACT/factory.bin := realtek-cr6c
endef

TARGET_DEVICES += gn866_ac

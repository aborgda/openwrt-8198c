# SPDX-License-Identifier: GPL-2.0-only
# RTL8198C bring-up profiles. Generic image layout is used until each board's
# vendor header, loader and flash partition map are verified against a dump.

define Device/rtl8198c_common
  SOC := rtl8198c
  DEVICE_DTS_DIR := ../dts-6.6
  IMAGE_SIZE := 16384k
endef

define Device/gn866_ac
  $(Device/rtl8198c_common)
  DEVICE_VENDOR := GN866
  DEVICE_MODEL := AC
endef
TARGET_DEVICES += gn866_ac

define Device/lg7100
  $(Device/rtl8198c_common)
  DEVICE_VENDOR := Realtek
  DEVICE_MODEL := LG7100
endef
TARGET_DEVICES += lg7100

define Device/sk337
  $(Device/rtl8198c_common)
  DEVICE_VENDOR := Realtek
  DEVICE_MODEL := SK337
endef
TARGET_DEVICES += sk337

# SPDX-License-Identifier: GPL-2.0-only
#
# Experimental image definition. The final factory/sysupgrade format must
# be verified against the GN866 AC bootloader and flash layout before use.
#
define Device/gn866_ac
  DEVICE_VENDOR := Realtek
  DEVICE_MODEL := GN866-AC
  DEVICE_DTS := rtl8198c_gn866-ac
  DEVICE_PACKAGES := 
  IMAGES := sysupgrade.bin
  IMAGE/sysupgrade.bin := append-kernel | pad-to 64k | append-rootfs | pad-rootfs | check-size | append-metadata
endef
TARGET_DEVICES += gn866_ac

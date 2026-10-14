# SPDX-License-Identifier: GPL-2.0-only
ARCH:=mips
SUBTARGET:=rtl8198c
BOARD:=realtek
BOARDNAME:=Realtek RTL8198C (experimental)
SOC:=rtl8198c

define Target/Description
	Experimental support scaffold for Realtek RTL8198C / GN866 AC.
	Kernel and bootloader support is incomplete; images are not yet validated.
endef

include $(INCLUDE_DIR)/target.mk

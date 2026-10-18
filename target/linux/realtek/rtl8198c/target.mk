# SPDX-License-Identifier: GPL-2.0-only
ARCH:=mips
SUBTARGET:=rtl8198c
CPU_TYPE:=24kc
BOARD:=realtek
BOARDNAME:=Realtek MIPS RTL8198C

KERNEL_PATCHVER:=6.6

define Target/Description
	Build RTL8198C Linux 6.6 images for GN866 AC, LG7100 and SK337 bring-up.
endef

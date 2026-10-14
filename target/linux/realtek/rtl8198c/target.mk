# SPDX-License-Identifier: GPL-2.0-only
# Initial RTL8198C subtarget scaffold for GN866 AC bring-up.
# CPU/toolchain and kernel support must be validated before producing flashable images.
ARCH:=mips
SUBTARGET:=rtl8198c
BOARD:=realtek
BOARDNAME:=Realtek RTL8198C

# Do not assume RTL838x CPU features for this SoC.

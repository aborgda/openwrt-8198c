# SPDX-License-Identifier: GPL-2.0-only
#
# Experimental RTL8198C / GN866 AC target scaffold.
# CPU type follows the MIPS 4KEc toolchain used by this OpenWrt target.
#
ARCH:=mips
SUBTARGET:=rtl8198c
BOARDNAME:=RTL8198C (experimental)
CPU_TYPE:=4kec
SOC:=rtl8198c
FEATURES+=usb

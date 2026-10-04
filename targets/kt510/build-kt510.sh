#!/bin/sh
set -eu

SDK_REPO="https://github.com/frederic/rtl819x-toolchain.git"
SDK_REF="5c9be5d943318fdb4d048ae22078129594eb5a10"
RSDK="rsdk-1.5.5-5281-EB-2.6.30-0.9.30.3-110714"

echo "KT510 build helper"
echo "Target: RTL8198 + RTL8192ER + RTL8812AR"
echo "Flash: 16 MiB"
echo "Toolchain: $RSDK"

git clone --depth 1 "$SDK_REPO" sdk
cd sdk
git fetch --depth 1 origin "$SDK_REF"
git checkout "$SDK_REF"

test -d "toolchain/$RSDK"
test -f boards/rtl8198/config.linux-2.6.30.RTL8198_SPI_SQUASHFS

cp boards/rtl8198/config.linux-2.6.30.RTL8198_SPI_SQUASHFS /tmp/kt510-kernel.config

cp .config .config.base
python3 - <<'PY'
from pathlib import Path
p = Path(".config.base")
s = p.read_text()
repl = {
    "CONFIG_BOARD_rtl8196e=y":"# CONFIG_BOARD_rtl8196e is not set",
    "# CONFIG_BOARD_rtl8198 is not set":"CONFIG_BOARD_rtl8198=y",
    "# CONFIG_RSDK_rsdk-1.3.6-5281-EB-2.6.30-0.9.30 is not set":"CONFIG_RSDK_rsdk-1.3.6-5281-EB-2.6.30-0.9.30=y",
    "# CONFIG_RSDK_rsdk-1.5.5-5281-EB-2.6.30-0.9.30.3-110714 is not set":"CONFIG_RSDK_rsdk-1.5.5-5281-EB-2.6.30-0.9.30.3-110714=y",
    "CONFIG_LINUX_2.6.30=y":"CONFIG_LINUX_2.6.30=y",
    "CONFIG_BOARDDIR=boards/rtl8196e":"CONFIG_BOARDDIR=boards/rtl8198",
    "CONFIG_RSDKDIR=toolchain/rsdk-1.3.6-4181-EB-2.6.30-0.9.30":"CONFIG_RSDKDIR=toolchain/rsdk-1.5.5-5281-EB-2.6.30-0.9.30.3-110714",
    "CONFIG_MODEL=RTL8196E_88E_GW":"CONFIG_MODEL=RTL8198_SPI_SQUASHFS",
}
for a,b in repl.items():
    s=s.replace(a,b)
p.write_text(s)
PY

cp .config.base .config

echo "KT510 profile prepared."
echo "The supplied 16 MiB dump is retained externally; GPIO/partition/header values remain dump-specific."
echo "Run 'make' with a compatible 32-bit host/toolchain to produce image/fw.bin."

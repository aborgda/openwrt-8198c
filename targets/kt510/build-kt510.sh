#!/bin/sh
set -eu

SDK_REPO="https://github.com/frederic/rtl819x-toolchain.git"
SDK_REF="5c9be5d943318fdb4d048ae22078129594eb5a10"

echo "KT510 build helper"
echo "Target: RTL8198 + RTL8192ER + RTL8812AR"
echo "Flash: 16 MiB"

git clone --depth 1 "$SDK_REPO" sdk
cd sdk
git fetch --depth 1 origin "$SDK_REF"
git checkout "$SDK_REF"

# Use the legacy RTL8198/SPI/SquashFS board definition.
cp boards/rtl8198/config.linux-2.6.30.RTL8198_SPI_SQUASHFS /tmp/kt510-kernel.config

# Generate a non-interactive top-level configuration from the SDK tree.
cp .config .config.base
python3 - <<'PY'
from pathlib import Path
p = Path(".config.base")
s = p.read_text()
repl = {
    "CONFIG_BOARD_rtl8196e=y":"# CONFIG_BOARD_rtl8196e is not set",
    "# CONFIG_BOARD_rtl8198 is not set":"CONFIG_BOARD_rtl8198=y",
    "CONFIG_LINUX_2.6.30=y":"CONFIG_LINUX_2.6.30=y",
    "CONFIG_BOARDDIR=boards/rtl8196e":"CONFIG_BOARDDIR=boards/rtl8198",
    "CONFIG_MODEL=RTL8196E_88E_GW":"CONFIG_MODEL=RTL8198_SPI_SQUASHFS",
}
for a,b in repl.items():
    s=s.replace(a,b)
# Do not invent dump-derived offsets here. The 16 MiB flash size is the only
# dump fact safe to carry into this generic legacy SDK profile.
p.write_text(s)

cp .config.base .config

echo "KT510 profile prepared."
echo "Run 'make' with a compatible 32-bit host/toolchain to produce image/fw.bin."

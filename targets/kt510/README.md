# KT510 — RTL8198 + RTL8192ER + RTL8812AR

Target definition for the KT510 board.

## Verified from the supplied dump
- Flash dump size: 16 MiB (16,777,216 bytes).
- SPI flash marking in the filename: GD25Q128B / WSON8.
- SoC/radio target requested: RTL8198 + RTL8192ER + RTL8812AR.

## Build base
The legacy Realtek RTL8198 SDK is the correct family for this board. It provides:
- RTL8198 board support
- Linux 2.6.30
- SPI + SquashFS image variants
- RTL8198 wireless PCIe plumbing and RTL8812 support hooks

## Important
GPIO, exact partition offsets, calibration data and image-header/checksum fields are NOT hard-coded here until they are extracted from the KT510 dump. Do not flash a generic image over the dump based on this manifest alone.

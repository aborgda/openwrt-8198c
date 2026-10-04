#!/usr/bin/env python3
import argparse
import struct
from pathlib import Path

HEADER = struct.Struct(">4sIII")


def checksum16(data: bytes) -> bytes:
    if len(data) & 1:
        data += b"\x00"
    total = 0
    for off in range(0, len(data), 2):
        total = (total + struct.unpack_from(">H", data, off)[0]) & 0xFFFF
    data += struct.pack(">H", (-total) & 0xFFFF)
    return data


def block(signature: bytes, ram: int, flash: int, payload: bytes) -> bytes:
    payload = checksum16(payload)
    return HEADER.pack(signature, ram, flash, len(payload)) + payload


def main() -> None:
    ap = argparse.ArgumentParser(description="Create Realtek CR6C/R6CR update image")
    ap.add_argument("output")
    ap.add_argument("kernel")
    ap.add_argument("rootfs")
    ap.add_argument("--kernel-ram", type=lambda x: int(x, 0), default=0x80000000)
    ap.add_argument("--kernel-flash", type=lambda x: int(x, 0), default=0x00030000)
    ap.add_argument("--rootfs-flash", type=lambda x: int(x, 0), default=0x00260000)
    args = ap.parse_args()

    kernel = Path(args.kernel).read_bytes()
    rootfs = Path(args.rootfs).read_bytes()

    image = (
        block(b"cr6c", args.kernel_ram, args.kernel_flash, kernel)
        + block(b"r6cr", 0, args.rootfs_flash, rootfs)
    )
    Path(args.output).write_bytes(image)

    if image[:4] != b"cr6c":
        raise SystemExit("CR6C header verification failed")

    pos = 0
    while pos < len(image):
        sig, ram, flash, length = HEADER.unpack_from(image, pos)
        pos += HEADER.size
        data = image[pos:pos + length]
        if len(data) != length:
            raise SystemExit("truncated Realtek image block")
        if sig not in (b"cr6c", b"r6cr"):
            raise SystemExit(f"unexpected Realtek signature: {sig!r}")
        total = sum(
            struct.unpack_from(">H", data, off)[0]
            for off in range(0, len(data), 2)
        ) & 0xFFFF
        if total != 0:
            raise SystemExit(f"checksum failed for {sig.decode()}")
        pos += length


if __name__ == "__main__":
    main()

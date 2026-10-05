#!/usr/bin/env python3
import argparse
import struct
from pathlib import Path

HEADER = struct.Struct(">4sIII")
SQUASHFS_MAGIC = b"hsqs"


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
    ap.add_argument("rootfs", nargs="?")
    ap.add_argument("--kernel-ram", type=lambda x: int(x, 0), default=0x80000000)
    ap.add_argument("--kernel-flash", type=lambda x: int(x, 0), default=0x00030000)
    ap.add_argument("--rootfs-flash", type=lambda x: int(x, 0), default=0x00260000)
    ap.add_argument("--kernel-span", type=lambda x: int(x, 0), default=0x00230000)
    args = ap.parse_args()

    if args.rootfs:
        kernel = Path(args.kernel).read_bytes()
        rootfs = Path(args.rootfs).read_bytes()
    else:
        combined = Path(args.kernel).read_bytes()
        root_pos = combined.find(SQUASHFS_MAGIC)
        if root_pos < 0:
            raise SystemExit("SquashFS rootfs magic not found in combined kernel/rootfs image")
        kernel = combined[:root_pos]
        rootfs = combined[root_pos:]

    if args.kernel_span < len(kernel):
        raise SystemExit(f"kernel {len(kernel):#x} exceeds span {args.kernel_span:#x}")
    kernel_payload = kernel + b"\xff" * (args.kernel_span - len(kernel))
    image = (
        block(b"cr6c", args.kernel_ram, args.kernel_flash, kernel_payload)
        + block(b"r6cr", 0, args.rootfs_flash, rootfs)
    )
    Path(args.output).write_bytes(image)

    pos = 0
    sigs = []
    while pos < len(image):
        sig, ram, flash, length = HEADER.unpack_from(image, pos)
        pos += HEADER.size
        payload = image[pos:pos + length]
        if len(payload) != length:
            raise SystemExit("truncated Realtek image block")
        if sig not in (b"cr6c", b"r6cr"):
            raise SystemExit(f"unexpected signature {sig!r}")
        if sum(struct.unpack_from(">H", payload, n)[0]
               for n in range(0, len(payload), 2)) & 0xFFFF:
            raise SystemExit(f"checksum failed for {sig.decode()}")
        sigs.append(sig)
        pos += length

    if sigs != [b"cr6c", b"r6cr"]:
        raise SystemExit(f"unexpected block order: {sigs!r}")


if __name__ == "__main__":
    main()

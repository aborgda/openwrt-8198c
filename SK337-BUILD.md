# SK337 custom firmware build

This branch requests these defaults:
- LAN: `192.168.1.1/24`
- Hostname: `sk337`
- Existing Wi-Fi AP SSIDs: `sk337` (existing encryption and keys are preserved)
- Device model string: `sk337`

GitHub Actions builds the repository's RTL8198C SK337 target and uploads a test artifact.

**Important:** this is a source build from this repository, not a byte-for-byte reconstruction of an uploaded vendor image. Do not flash the artifact until its exact board compatibility, flash geometry, vendor header, and recovery path are verified. The repository's current target image definition declares a 16 MiB image size; the uploaded candidate is smaller, so this build must be treated as a test artifact, not a flash-ready replacement.

# GN866 AC / RTL8198C Linux 6.6 port status

This branch is a migration workspace for the GN866 AC target on the official
OpenWrt 24.10 series (Linux 6.6). It is intentionally separate from master.

Changes in this commit:
- Select Linux 6.6 in the Realtek target and RTL8198C subtarget metadata.
- Add a config-6.6 starting point copied from the previous config-5.10.
- Keep the GN866 AC DTS, image definition, and RTL8198C loader sources for porting.

Important:
- config-6.6 is only a starting point, not yet validated against Linux 6.6 Kconfig.
- This does not yet replace the full repository source with the official OpenWrt
  24.10 source tree.
- Do not flash firmware from this branch until a clean build and image-layout
  verification have succeeded.

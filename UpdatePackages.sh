#!/bin/sh

apt-ftparchive packages ./debs/ > Packages
xz -c9 Packages > Packages.xz
zstd -q -c19 Packages > Packages.zst

apt-ftparchive release -c config/iphoneos-arm64.conf . > \
	Release 2>/dev/null

gpg -abs -u 7D3B36CEA40FCC2181FB6DCDBAFFD97826540F1C -o Release.gpg Release

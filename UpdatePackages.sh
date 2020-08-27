#!/bin/sh

apt-ftparchive packages ./debs/ > Packages
xz -c9 Packages > Packages.xz
zstd -q -c19 Packages > Packages.zst

apt-ftparchive release -c release.conf . > \
	Release 2>/dev/null

rm Release.gpg; gpg -abs -u 7D3B36CEA40FCC2181FB6DCDBAFFD97826540F1C -o Release.gpg Release
rm InRelease; gpg -abs -u 7D3B36CEA40FCC2181FB6DCDBAFFD97826540F1C --clearsign -o InRelease Release

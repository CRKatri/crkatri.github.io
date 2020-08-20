#!/bin/sh

apt-ftparchive packages ./debs/ > Packages
xz -c9 Packages > Packages.xz
zstd -q -c19 Packages > Packages.zst
gpg -abs -u 7D3B36CEA40FCC2181FB6DCDBAFFD97826540F1C -o Release.gpg Release

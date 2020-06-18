#!/bin/sh

apt-ftparchive packages ./debs/ > Packages
xz -c9 Packages > Packages.xz
zstd -q -c19 Packages > Packages.zst

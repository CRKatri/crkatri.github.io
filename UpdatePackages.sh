#!/bin/sh

rm Packages.old
mv Packages Packages.old
dpkg-scanpackages --multiversion debs > Packages
rm Packages.gz
rm Packages.bz2
bzip2 -k Packages
gzip -k Packages

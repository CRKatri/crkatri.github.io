#!/bin/sh

rm Packages
dpkg-scanpackages --multiversion ./debs > Packages
rm Packages.gz
rm Packages.bz2
bzip2 -9fk Packages
gzip -9fk Packages

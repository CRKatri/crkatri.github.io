#!/bin/sh

echo "building $1"
dpkg-deb -b $1 .

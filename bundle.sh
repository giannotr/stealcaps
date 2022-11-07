#!/bin/bash

if [ $# -ne 4 ]; then
  echo "Wrong number of flags or empty arguments";
	exit 1;
fi

if [ "$1" != "-n" ]; then
  echo "Unkown flag:" $1;
	exit 1;
fi

if [ "$3" != "-p" ]; then
  echo "Unkown flag:" $3;
	exit 1;
fi

PKG=$2;
PREV_VERSION=$4;

# Compile documentation
pdflatex $PKG.dtx;
pdflatex $PKG.dtx;

# Store files in tds compliant directories
PKG_DIR=$PKG;

mkdir $PKG_DIR;

cp README.md $PKG_DIR;
cp $PKG.pdf $PKG_DIR;
cp $PKG.dtx $PKG_DIR;
cp $PKG.ins $PKG_DIR;

cp -r testfile $PKG_DIR;

# Bundle to zip

cp $PKG.zip $PKG-v$PREV_VERSION.zip;
rm $PKG.zip;

zip -vr $PKG.zip $PKG_DIR/ -x "*.DS_Store";
rm -r $PKG_DIR;

echo "bundle.sh:" $PKG "package and documentation successfully compiled and bundled";

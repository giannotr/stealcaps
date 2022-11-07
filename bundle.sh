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

# Compile PKG
latex $PKG.ins;

# Compile documentation
pdflatex $PKG.dtx;
pdflatex $PKG.dtx;

# Store files in tds compliant directories
PKG_DIR=$PKG.tds;

mkdir $PKG_DIR;
mkdir $PKG_DIR/doc;
mkdir $PKG_DIR/source;
mkdir $PKG_DIR/tex;

mkdir $PKG_DIR/doc/latex;
mkdir $PKG_DIR/source/latex;
mkdir $PKG_DIR/tex/latex;

mkdir $PKG_DIR/doc/latex/$PKG;
mkdir $PKG_DIR/source/latex/$PKG;
mkdir $PKG_DIR/tex/latex/$PKG;

cp README.md $PKG_DIR/doc/latex/$PKG;
cp $PKG.pdf $PKG_DIR/doc/latex/$PKG;

cp $PKG.dtx $PKG_DIR/source/latex/$PKG;
cp $PKG.ins $PKG_DIR/source/latex/$PKG;

cp $PKG.sty $PKG_DIR/tex/latex/$PKG;
rm $PKG.sty;

# Bundle to zip

cp $PKG.tds.zip $PKG-v$PREV_VERSION.tds.zip;
rm $PKG.tds.zip;

zip -vr $PKG.tds.zip $PKG_DIR/ -x "*.DS_Store";
rm -r $PKG_DIR;

echo "bundle.sh:" $PKG "package and documentation successfully compiled and bundled";

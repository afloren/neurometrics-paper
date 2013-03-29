#!/bin/bash

E_BADARGS=65

BIBTEX_ARGS= 
LATEX_ARGS="-interaction=batchmode"
DIFF_PDF=diff.pdf
DIFF_AUX=diff.aux
DIFF_TEX=diff.tex
LATEXDIFF_DIR=latexdiff
GIT_REPO=.
NEW_REV=master
OLD_REV=master~1
DOC_TEX= 

if [ $# -lt 1 -o $# -gt 3 ]
then
  echo "Usage: `basename $0` DOC_TEX [OLD_REV [NEW_REV]]"
  exit $E_BADARGS
fi

if [ $# -gt 0 ]
then
  DOC_TEX=$1
fi

if [ $# -gt 1 ]
then
  OLD_REV=$2
fi

if [ $# -gt 2 ]
then
  NEW_REV=$3
fi



mkdir -p $LATEXDIFF_DIR
git clone $GIT_REPO $LATEXDIFF_DIR/old
git clone $GIT_REPO $LATEXDIFF_DIR/new
pushd $LATEXDIFF_DIR/old
git checkout $OLD_REV
popd
pushd $LATEXDIFF_DIR/new
git checkout $NEW_REV
popd
pushd $LATEXDIFF_DIR
latexdiff old/$DOC_TEX new/$DOC_TEX > new/$DIFF_TEX
popd
pushd $LATEXDIFF_DIR/new
pdflatex $LATEX_ARGS $DIFF_TEX
bibtex $BIBTEX_ARGS $DIFF_AUX
pdflatex $LATEX_ARGS $DIFF_TEX
pdflatex $LATEX_ARGS $DIFF_TEX
popd
cp $LATEXDIFF_DIR/new/$DIFF_PDF $LATEXDIFF_DIR/$DIFF_PDF

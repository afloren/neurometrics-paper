#!/bin/bash

mkdir -p $2
git clone $1 $2/old
git clone $1 $2/new
pushd $2/old
git checkout $3
popd
pushd $2/new
git checkout $4
popd
latexdiff $2/old/$5 $2/new/$5 > $2/new/diff.tex
pushd $2/new
pdflatex diff.tex
bibtex diff.aux
pdflatex diff.tex
pdflatex diff.tex
popd
cp $2/new/diff.pdf $2/diff.pdf

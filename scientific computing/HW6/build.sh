#!/bin/bash
builder()
{
rm *.o *.mod homework4
cp xycoord_$1.f90 xycoord.f90
sleep 1
make
mv grid.jpg grid_$1.jpg
mv max.jpg max_$1.jpg
}

builder f1
builder f2
builder f3
builder f4
pdflatex *.tex
cp MATH*.pdf Report
make clean

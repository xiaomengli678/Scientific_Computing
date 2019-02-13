# Makefile
output.txt x.txt y.txt: main.x
	./main.x > output.txt x.txt y.txt
main.x: xycoord.o differentiate.o printdble.o approerror.o homework4.o
	gfortran -o main.x xycoord.o differentiate.o printdble.o approerror.o homework4.o 

xycoord.o xycoord.mod: xycoord.f90 homework4.f90
	gfortran -c xycoord.f90 homework4.f90

differentiate.o: differentiate.f90
	gfortran -O3 -c differentiate.f90

printdble.o: printdble.f90
	gfortran -O3 -c printdble.f90

approerror.o: approerror.f90
	gfortran -O3 -c approerror.f90

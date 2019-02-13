# Makefile

output.txt: GaussQuadrature.x
	./GaussQuadrature.x > output.txt

GaussQuadrature.x: GaussQuadrature.o lglnodes.o
	gfortran GaussQuadrature.o lglnodes.o -o GaussQuadrature.x
        
GaussQuadrature.o: GaussQuadrature.f90
	gfortran -O3 -c GaussQuadrature.f90

lglnodes.o: lglnodes.f90
	gfortran -O3 -c lglnodes.f90

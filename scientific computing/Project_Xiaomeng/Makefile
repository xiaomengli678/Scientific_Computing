#FC=mpif90
FC=gfortran
#FFLAGS = -g -Wall -Wextra -O -fcheck=all -finit-real=nan -finit-integer=-536870911
#FFLAGS = -fsanitize=address -g
FFLAGS = -g
#FFLAGS = -O2
DEPS=wave2dh.o printble.o Project_serial.o
.PHONY: clean clean_all

all: project

%.mod:%.f90
	$(FC) $(FFLAGS) -c $<

%.o:%.f90
	$(FC) $(FFLAGS) -c $<

project:$(DEPS)
	$(FC) $(FFLAGS) -o $@ $(DEPS)

clean:
	rm -f *.o *.mod *.txt

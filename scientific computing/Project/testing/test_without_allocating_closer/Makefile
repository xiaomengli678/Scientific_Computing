FC=gfortran
FFLAGS = -g
.PHONY: clean clean_all
DEPS=err_calc.o  wave2d.o  x_manip.o printdble.o

all: project

%.o:%.f90
	$(FC) $(FFLAGS) -c $<

project:Project.f90 $(DEPS)
	$(FC) $(FFLAGS) -o $@ $?

clean:
	rm -f *.o *.txt project

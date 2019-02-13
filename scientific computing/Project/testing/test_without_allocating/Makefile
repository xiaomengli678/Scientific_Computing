FC=gfortran
FFLAGS = -g
.PHONY: clean clean_all
DEPS=testing.o  x_creator.o  x_manip.o

all: test

%.o:%.f90
	$(FC) $(FFLAGS) -c $<

test:test.f90 $(DEPS)
	$(FC) $(FFLAGS) -o $@ $?

clean:
	rm -f *.o

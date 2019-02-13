FC=gfortran
FFLAGS = -g
.PHONY: clean clean_all
ALL=test_laplac test_u_exact test_forcing test_f2_fun
all: $(ALL)
wave2dh.mod:../wave2dh.f90
	$(FC) $(FFLAGS) -c $<

test_laplac:test_laplac.f90 ../wave2dh.f90
	$(FC) $(FFLAGS) -o $@ $?

test_u_exact:test_u_exact.f90 ../wave2dh.f90
	$(FC) $(FFLAGS) -o $@ $?

test_forcing:test_forcing.f90 ../wave2dh.f90
	$(FC) $(FFLAGS) -o $@ $?

test_f2_fun:test_f2_fun.f90 ../wave2dh.f90
	$(FC) $(FFLAGS) -o $@ $?

clean:
	rm -f *.o $(ALL)

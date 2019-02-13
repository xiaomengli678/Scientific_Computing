FC=mpif90
#FC=gfortran
#FFLAGS = -g -Wall -Wextra -O -fcheck=all -finit-real=nan -finit-integer=-536870911
#FFLAGS = -fsanitize=address -g
#FFLAGS = -g
#FFLAGS = -O2
DEPS=wave2dh.o printble.o
SDEPS=$(DEPS) Project_serial.o
PDEPS=$(DEPS) Project_mpi.o
W100=$(DEPS) Project_mpi_100.o
W141=$(DEPS) Project_mpi_141.o
W173=$(DEPS) Project_mpi_173.o
W200=$(DEPS) Project_mpi_200.o
W223=$(DEPS) Project_mpi_223.o
W244=$(DEPS) Project_mpi_244.o
W264=$(DEPS) Project_mpi_264.o
W282=$(DEPS) Project_mpi_282.o

.PHONY: clean clean_all

all: project_serial project_mpi project_mpi_w100 project_mpi_w141 project_mpi_w173 project_mpi_w200 project_mpi_w223 project_mpi_w244 project_mpi_w264 project_mpi_w282

%.mod:%.f90
	$(FC) $(FFLAGS) -c $<

%.o:%.f90
	$(FC) $(FFLAGS) -c $<

project_serial:$(SDEPS)
	$(FC) $(FFLAGS) -o $@ $(SDEPS)

project_mpi:$(PDEPS)
	$(FC) $(FFLAGS) -o $@ $(PDEPS)

project_mpi_w100:$(W100)
	$(FC) $(FFLAGS) -o $@ $(W100)

project_mpi_w141:$(W141)
	$(FC) $(FFLAGS) -o $@ $(W141)

project_mpi_w173:$(W173)
	$(FC) $(FFLAGS) -o $@ $(W173)

project_mpi_w200:$(W200)
	$(FC) $(FFLAGS) -o $@ $(W200)

project_mpi_w223:$(W223)
	$(FC) $(FFLAGS) -o $@ $(W223)

project_mpi_w244:$(W244)
	$(FC) $(FFLAGS) -o $@ $(W244)

project_mpi_w264:$(W264)
	$(FC) $(FFLAGS) -o $@ $(W264)

project_mpi_w282:$(W282)
	$(FC) $(FFLAGS) -o $@ $(W264)

clean:
	rm -f *.o *.mod

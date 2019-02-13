#!/bin/bash
#
# easy way to run on both the cluster and locally.
# So that you can just run ./run.sh
# it will compile with ifort and start a job
# if it sees the sbatch command
# otherwise it will compile with gcc and run ./ompbatch_16.job
#
# add option "serial" on a machine without sbatch
# to compile and run in serial mode
# timing files are left out because we used openmp's
# timing functions
#

make clean
rm ./homework6
if [ "$(which sbatch)" = "" ];then
 if [ "$1" = "serial" ];then
  cp Makefile.gcc-serial Makefile
 else
  cp Makefile.gcc-openmp Makefile
 fi
 make
 make clean
 if [ -f ./homework6 ];then
  bash ./ompbatch_16.job
 fi
else
 cp Makefile.ifort Makefile
 make clean
 make
 make clean
 if [ -f ./homework6 ];then
  sbatch ./ompbatch_16.job
 fi
fi

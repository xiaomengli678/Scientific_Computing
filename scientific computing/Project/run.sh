#!/bin/bash

./project_serial
mpirun -np 3 ./project_mpi

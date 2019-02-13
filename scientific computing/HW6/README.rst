+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
README file for Homework 6, Math/CS 471, Fall 2017, Xiaomeng and Jeff
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

- This readme is located in the Homework 6 folder. The report is located in the Report folder.
- The files included are:
	1. differentiate.f90: Given file.
	2. homework4.f90: Calls upon the other files and subroutines to approximate a grid
	3. build.sh: runs make on each function set
	4. Makefile: compiles the code and outputs the graphs
	5. plotgrid.m: used by Makefile to output the graphs
	6. printdble.f90: Given file.
	7. split.sh: used to split a coupled.txt file that has a bunch of different variables to it
	8. xy_coord.f90: Given file.
	
To reproduce the results:
	1. Download the code using the command "git clone https://xxx@bitbucket.org/beseng/Math471Seng/hw3.git"
	2. Navigate to the file in the shell
	3. Make the files needed using the command "make"
	4. To plot the errors, run the file plotgrid.m.

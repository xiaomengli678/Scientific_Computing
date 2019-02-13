+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
The README file for Homework 4 in lower-level directory, 10/29/2017 Xiaomeng Li
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

The lower-level directory includes all the required codes and report for HW4.

- The HW4 report is in the directory HW4 and it is called HW4_Report.pdf. You can also 
  find it in the folder called Report. The name is the same. Note that since this time I did  
  homework with Microsoft Word so there are not many other files.

- The Code for this HW4 is divided into three parts. Folder equation_a, equation_b and equation_c.
  Folder equation_a has all the fortran codes for the error analysis of equation a mentioned in the report.
  Folder equation_b has all the fortran codes for the error analysis of equation b mentioned in the report.
  Folder equation_c has all the fortran codes for the error analysis of equation c mentioned in the report.
  
- There are five other folders which are the codes helping me to keep track of every coding section. Please ignore them.

- In order to implement equation_a, please go to the folder and type make -f Makefile in the terminal. The outputs will be in 
  the output.txt. Note that every folder has a MATLAB file called Errorreading.m. It will plot the grid size vs maximum
  error directly. To implement it, open MATLAB and press "RUN". To implement the codes in the other two folders, the procedure 
  is the same.

- Note that I leave a .txt file in folder equation_c. It is called 2D trapezoidal rule and chain rule.txt. Within this txt file,
  I leave the code necessary for implement 2D trapezoidal rule and chain rule for delta u = uxx + uyy. The languages are all 
  in fortran. When I need to implement them separately, I just input the code in the right position of every folder's homework4.f90
  




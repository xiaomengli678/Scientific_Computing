+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
The README file for Homework 3 in lower-level directory, 10/1/2017 Xiaomeng Li
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

The lower-level directory includes all the required codes and report for HW3

- The HW3 report is in the directory HW3 and it is called HW3_auto.pdf. You can also 
find it in the folder Report_Matlab. The name is the same. 

- The Code for this HW3 is divided into two parts.
The Part I: Trapezoidal rule codes are in the folder called Part1_Codes
The Part II: Gauss Quadrature codes are in the folder called Part2_Codes

- The folder called Report_Matlab is used for producing this HW3 report. It includes 
everything required for data analysis (Matlab) and Latex report (by Perl).

- To produce the results in Part I: Trapezoidal rule (part 1 in HW3) please do this: 
  1. Open Part1_Codes folder. There will be a Makefile. Type in the command: make -f Makefile 
  in the terminal then there will be outputs. 
   
  2.When you want the results for different n and error with k = pi, run "error = abs(thr1 - sum1)" 
  and comment "error = abs(thr2 - sum2)". Similarly run "error = abs(thr2 - sum2)" and comment 
  "error = abs(thr1 - sum1)" for the case k = pi * pi.
  
  3.The two files called output_pi.txt and output_pipi.txt are the data I already 
  ran. Later I will incorporate both of them in Matlab file to do data plot.
  
- To produce the results in Part II: Gauss Quadrature (part 2 in HW3) please do this:
  1. Open Part2_Codes folder. There will be a Makefile. Type in the command: make -f Makefile 
  in the terminal then there will be outputs. 
  
  2. When you want the results for different n and error with k = pi, run "error = abs(thr1 - Integral_value)" 
  and  "f = exp(cos(pi*x))". Comment "error = abs(thr2 - Integral_value)" and "f = exp(cos(pi*pi*x))". 
  Similarly run "error = abs(thr2 - Integral_value)" and "f = exp(cos(pi*pi*x))". Comment 
  "error = abs(thr1 - Integral_value)" and "f = exp(cos(pi*x))" for the case k = pi * pi. 
  
  3. The two files called output_pi.txt and output_pipi.txt are the data I already 
  ran. Later I will incorporate both of them in Matlab file to do data plot.
  
- To produce the data report for this HW3. Please do this:
  1. HW3.perl is the Perl file. Open terminal, type in "perl HW3.perl" and then a PDF file called
  HW3_auto.pdf would be produced. This is the report for this HW3.  
  
  2. A few instructions: HW3_1.m is the data plot used for Part I: Trapezoidal rule
                         HW3_2.m is the data plot used for Part II: Gauss Quadrature
                         fit_1.m is the fit data I use for Gauss Quadrature with C and a for k = pi.
                         fit_2.m is the fit data I use for Gauss Quadrature with C and a for k = pi * pi.
                         HW3.mat includes all the data produced from last two Fortran procedures Part I and II.
                         (P1 Workspace for Trapezoidal rule and P2 Workspace for Gauss Quadrature)
  
  
  


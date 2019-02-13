+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
The README file for Homework 2 in lower-level directory, 09/16/2017 Xiaomeng Li
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

The lower-level directory includes all the required codes and report for HW2

- The homework report is in the directory
  HW2 and is called HW2_auto.pdf.
- The necessary code for this homework is located in HW2/Codes. 
- Some data files and results are placed in HW2/Files. I didn't include them in the 
  HW2_auto.pdf since I just use them to represent data more clearly. For example, 
  all the data with convergence values are in the tmpwithwatchingcovergence.txt. 
  All the data with x, dx only are in the tmpwithoutwatchingcovergence.txt. In fact, I 
  come up with a cleaner and more readable report using the files in HW2/Files. The
  HW2_auto.pdf report right now in HW2 upper level is produced by HW2/Files. 
- To reproduce the results in the report, it is necessary to recognize two code files: 
  newtonS.pl and HW2.perl. 
  
  newtonS.pl is used for incorporating Fortran and Newton's method and producing the 
  final convergence data results.
  
  HW2.perl. is used for producing LaTeX results so that we can watch the PDF report 
  produced by Perl and LaTeX language.
  
  1. type "perl newtonS.pl" in terminal, press return. 
  Then all the results should come up. Two new files now should be produced.
  tmp.txt is the result .txt file. tmp2.tex file is the result .tex file.
  Both of the files contain the same results. .tex file is different since I add "&"
  symbol in order to make it readable for LaTeX.
  
  2. Then, please type "perl HW2.perl" in terminal, press return. 
  Actually at this moment terminal will print a lot of sentences. There will be a moment 
  when a symbol "?" and a rectangular come up. I suppose it is something wrong with
  the .tex data file I used though I didn't figure it out. So before the terminal 
  processing is over, please press return all the time.
  
  3. In the end, a PDF file with the name HW2_auto.pdf will be produced. Actually, I feel 
  the report made by this HW2/Codes is too messy. So I use HW2/Files to produce a more 
  readable report. You only need to open HW2/Files and run "perl HW2.perl" in terminal,
  press return. Whatever comes up just keep pressing return. A cleaner report will be 
  produced.
  
  Explanation: The .tex file which HW2.perl used for outputting LaTeX PDF files is not 
  the original .tex files produced by newtonS.pl. Because I really could not find a way to
  add the symbol "\\" at the end of each data row. Therefore, I added the "\\" myself, 
  renamed it as tmp2modify.tex and used this file as the input .tex file for HW2.perl. 
  That is why I added the Files folder to watch data more clearly. The same thing goes 
  for tmp1.tex and tmp2.tex in folder HW2/Files, I added the "\\" myself.
  
  
  


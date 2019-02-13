#!/usr/apps/bin/perl

# Tabove is to tell the shell that this is a perl script
#
# This simple perl program opens the file lab1.tex.TEMPLATE  
# and performs some text string substitutions and saves it under a new name
# 
#
# run with : perl lab1.perl
#
#
# These are the names of the template and output files. 
#$cmdFile="./lab1.tex.Template";
$cmdFile="./lab1.tex";
$outFile="./lab1_auto.tex";

$author1 = "Kalle Anka";
$author2 = "Xiaomeng Li";

# Open the Template file and the output file. 
open(FILE,"$cmdFile") || die "cannot open file $cmdFile!" ;
open(OUTFILE,"> $outFile") || die "cannot open file $outFile!!" ;
# Setup the output file based on the template
# read one line at a time from the template file
while( $line = <FILE> )
  {
    # Replace the the stings by using substitution
    # s
    $line =~ s/AUTHOR1/$author1/;
    $line =~ s/AUTHOR2/$author2/;

    print OUTFILE $line;
    # You can always print to secreen to see what is happening.
    # Uncomment the next line to print the output to the screen.  
    print $line;
  }
# Close the files
close( OUTFILE );
close( FILE );

system("diff lab1.tex lab1_auto.tex"); 
system("pdflatex lab1_auto.tex");
system("ls -ltr");
system("open -a preview lab1_auto.pdf ");
# system('export PATH=$PATH:/Applications/MATLAB_R2017a.app/bin/');
system("nohup matlab -nosplash -nodisplay < lab1.m > output.txt");
exit 


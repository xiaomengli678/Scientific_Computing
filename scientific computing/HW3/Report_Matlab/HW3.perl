#!/usr/apps/bin/perl

# Tabove is to tell the shell that this is a perl script
$cmdFile="./HW3.tex";
$outFile="./HW3_auto.tex";
#!/usr/apps/bin/perl
$author1 = "Xiaomeng Li";

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
    
    print OUTFILE $line;
    # You can always print to secreen to see what is happening.
    # Uncomment the next line to print the output to the screen.  
    # print $line;
  }
# Close the files
close( OUTFILE );
close( FILE );

# system("diff HW2.tex HW2_auto.tex"); 
system("pdflatex HW3_auto.tex");
# system("ls -ltr");
system("open -a preview HW3_auto.pdf ");
# system('export PATH=$PATH:/Applications/MATLAB_R2017a.app/bin/');
# system("nohup matlab -nosplash -nodisplay < HW3_1.m > output.txt");
# system("nohup matlab -nosplash -nodisplay < HW3_2.m > output.txt");
# system("nohup matlab -nosplash -nodisplay < fit_1.m > output.txt");
# system("nohup matlab -nosplash -nodisplay < fit_2.m > output.txt");
exit 

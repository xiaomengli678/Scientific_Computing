#!/usr/apps/bin/perl
#
# perl program to try the convergence for different functions 
# when using Newton's method for f(x) = 0
# run with : perl newton.pl
#
#
# Here is the generic file
$txtFile1="./tmpwithoutwatchingcovergence.txt";
$txtFile2="./tmpwithwatchingcovergence.txt";
$txtFile3="./tmp1.tex";
$txtFile4="./tmp2.tex";

# Stuff to converge over




open(FILE1, "$txtFile1") || die "cannot open file!" ;



open(FILE1, "$txtFile1") || die "cannot open file!" ;
open(FILE2, "$txtFile2") || die "cannot open file!" ;
open(FILE3, " >>$txtFile3") || die "cannot open file!" ;
open(FILE4, " >>$txtFile4") || die "cannot open file!" ;
 while( $line = <FILE1> )
 {
 $line =~ s/\s+/ & /g;  # Globally replace chunks of whitespace with a " , "
 $line =  $line . "\n"; # Add a newline as the above removes it.
 $line =~ s/ & $/ /;    # Remove the last " , "
 $line =~ s/ & / /;     # Remove the first " , "
 print FILE3 $line;           # Print to file 
}
while( $line = <FILE2> )
 {
 $line =~ s/\s+/ & /g;  # Globally replace chunks of whitespace with a " , "
 $line =  $line . "\n"; # Add a newline as the above removes it. 
 $line =~ s/ & $/ /;    # Remove the last " , "
 $line =~ s/ & / /;     # Remove the first " , "
 print FILE4 $line;           # Print to file 
}
close( FILE1 );
close( FILE2 );
close( FILE3 );
close( FILE4 );   





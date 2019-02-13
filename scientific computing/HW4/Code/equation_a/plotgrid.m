clear all
close all
load x.txt 
load y.txt 

plot(x,y,'k',x',y','k')
axis equal
print -depsc2 grid.eps
clear all;
close all;
load strong_large.txt

speedup = strong_large(1)./strong_large;
eff = speedup./linspace(1,16,16);

%figure(1)
plot(linspace(1,16,16),speedup)
ylabel('speedup','FontSize', 24);
xlabel('number of threads','FontSize', 24);
set(gca,'FontSize',22);
print -djpeg speedup_strong_large.jpg;
%figure(2)
plot(linspace(1,16,16),eff)
ylabel('efficiency','FontSize', 24);
xlabel('number of threads','FontSize', 24);
set(gca,'FontSize',22);
print -djpeg efficiency_strong_large.jpg;

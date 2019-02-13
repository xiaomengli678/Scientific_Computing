clear all;
close all;
load strong_small.txt

speedup = strong_small(1)./strong_small;
eff = speedup./linspace(1,16,16);

%figure(1)
plot(linspace(1,16,16),speedup)
ylabel('speedup');
xlabel('number of threads');
print -djpeg speedup_strong_small.jpg;
%figure(2)
plot(linspace(1,16,16),eff)
ylabel('efficiency');
xlabel('number of threads');
print -djpeg efficiency_strong_small.jpg;

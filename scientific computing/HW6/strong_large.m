clear all;
close all;
load strong_large.txt

speedup = strong_large(1)./strong_large;
eff = speedup./linspace(1,16,16);

%figure(1)
plot(linspace(1,16,16),speedup)
ylabel('speedup');
xlabel('number of threads');
print -djpeg speedup_strong_large.jpg;
%figure(2)
plot(linspace(1,16,16),eff)
ylabel('efficiency');
xlabel('number of threads');
print -djpeg efficiency_strong_large.jpg;

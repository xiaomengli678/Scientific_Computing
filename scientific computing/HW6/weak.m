clear all;
close all;
load weak.txt

speedup = weak(1)./weak;
eff = speedup./linspace(1,16,16);

%figure(1)
plot(linspace(1,16,16),speedup)
ylabel('speedup');
xlabel('number of threads');
print -djpeg speedup_weak.jpg;
%figure(2)
plot(linspace(1,16,16),eff)
ylabel('efficiency');
xlabel('number of threads');
print -djpeg efficiency_weak.jpg;

clear all;
close all;
load time.txt

speedup = time(1)./time;
eff = speedup./linspace(1,16,16);

%figure(1)
plot(linspace(1,16,16),speedup)
ylabel('speedup');
xlabel('number of threads');
print -djpeg speedup.jpg;
%figure(2)
plot(linspace(1,16,16),eff)
ylabel('efficiency');
xlabel('number of threads');
print -djpeg efficiency.jpg;

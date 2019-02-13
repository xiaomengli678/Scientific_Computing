clear all;
close all;
load time.txt

speedup = time(1)./time;
eff = speedup./linspace(1,16,16);

%figure(1)
plot(linspace(1,16,16),speedup)
ylabel('speedup','FontSize', 24);
xlabel('number of threads','FontSize', 24);
set(gca,'FontSize',22);
print -djpeg speedup.jpg;
%figure(2)
plot(linspace(1,16,16),eff)
ylabel('efficiency','FontSize', 24);
xlabel('number of threads','FontSize', 24);
set(gca,'FontSize',22);
print -djpeg efficiency.jpg;

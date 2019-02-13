clear all;
close all;
load time_n1.txt
load time_n2.txt
load time_n3.txt
load time_n4.txt
load time_n5.txt
load time_n6.txt
load time_n7.txt
load time_n8.txt

time = [time_n1(6);time_n2(6);time_n3(6);time_n4(6);time_n5(6);time_n6(6);time_n7(6);time_n8(6)];
speedup = time(1)./time;
eff = speedup./linspace(1,8,8)';

%figure(1)
plot(linspace(1,8,8),speedup)
ylabel('speedup','FontSize', 24);
xlabel('number of threads','FontSize', 24);
set(gca,'FontSize',22);
print -djpeg speedup_strong.jpg;
%figure(2)
plot(linspace(1,8,8),eff)
ylabel('efficiency','FontSize', 24);
xlabel('number of threads','FontSize', 24);
set(gca,'FontSize',22);
print -djpeg efficiency_strong.jpg;

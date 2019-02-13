clear all;
close all;

w=[0.1187839508056641E+00;0.1888501644134521E+00;0.2193439006805420E+00;0.2657799720764160E+00;0.3043069839477539E+00;0.3257658481597900E+00;0.3352069854736328E+00];
speedup = w(1)./w;
eff = speedup./linspace(1,7,7)';

%figure(1)
plot(linspace(1,7,7),speedup)
ylabel('speedup','FontSize', 24);
xlabel('number of threads','FontSize', 24);
set(gca,'FontSize',22);
print -djpeg speedup_weak.jpg;
%figure(2)
plot(linspace(1,7,7),eff)
ylabel('efficiency','FontSize', 24);
xlabel('number of threads','FontSize', 24);
set(gca,'FontSize',22);
print -djpeg efficiency_weak.jpg;

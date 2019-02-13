clear all
close all
s = csvread('output.txt'); 
figure
loglog(s(:,1),s(:,2),'r-o');
hold on 
loglog(s(:,1),s(:,1).^2,'b-*');
grid on
hold off
xlabel('grid spacing h')
ylabel('error')
legend('error','h^2')

print -depsc2 plot_function1.eps
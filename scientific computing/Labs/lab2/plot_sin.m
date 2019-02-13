% Simple program for generating a plot

x = linspace(0,2*pi,100);
y=sin(x);

set(gca,'fontsize',20)
plot(x,y,'k','linewidth',2)
xlabel('x')
ylabel('y')

print -depsc2 plot_sin
%print -dpng error_v1

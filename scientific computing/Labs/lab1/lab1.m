clear 
clf

x = linspace(-1,1,120);
y = exp(1/2-sin(5*pi*x));

p = loglog(x,y,'b--o');
p.LineWidth = 4;
xlabel("X value")
ylabel("Y value")
title("X - Y plot")
grid on
print -depsc2 lab1.eps
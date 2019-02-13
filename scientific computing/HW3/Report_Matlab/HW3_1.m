%% Part I: Trapezoidal rule
figure(1)
loglog (P1(:,1),P1(:,2),'r-*')
hold on
loglog (P1(:,3),P1(:,4),'b-o')
grid on 
xlabel ('magnitude of n')
ylabel ('magnitude of error')
legend('Trapezoidal rule with k = pi', 'Trapezoidal rule with k = pi*pi')
title ('Trapezoidal rule plot with k = pi and pi*pi')
hold off
print -depsc2 Trapezoidal.eps

%% Part II: Gauss Quadrature
figure(2)
loglog (P2(:,1),P2(:,2),'r-*')
hold on
loglog (P2(:,3),P2(:,4),'b-o')
grid on 
xlabel ('magnitude of n')
ylabel ('magnitude of error')
legend('Gauss Quadrature rule with k = pi', 'Gauss Quadrature rule with k = pi*pi')
title ('Gauss Quadrature rule plot with k = pi and pi*pi')
hold off
print -depsc2 Gauss.eps
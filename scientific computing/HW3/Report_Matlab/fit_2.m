%% Part II: Gauss Quadrature
n2 = P2(1:100,3);
C2 = 70;
a2 = 0.09;
y2 = C2.^(-a2*n2);
figure(2)
%loglog (P2(:,1),P2(:,2),'r-*')
% hold on
loglog (P2(:,3),P2(:,4),'b-*')
hold on
loglog (n2,y2,'g-o')
grid on 
xlabel ('magnitude of n')
ylabel ('magnitude of error')
legend('Gauss Quadrature rule with k = pi*pi','new fit curve')
title ('Gauss Quadrature rule plot with pi*pi and new fit curve')
hold off
print -depsc2 Gauss_fit_2.eps
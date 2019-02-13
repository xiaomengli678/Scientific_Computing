%% Part II: Gauss Quadrature
n1 = P2(1:100,1);
C1 = 1000;
a1 = 0.1;
y1 = C1.^(-a1*n1);
figure(2)
loglog (P2(:,1),P2(:,2),'r-*')
% hold on
% loglog (P2(:,3),P2(:,4),'b-o')
hold on
loglog (n1,y1,'g-o')
grid on 
xlabel ('magnitude of n')
ylabel ('magnitude of error')
legend('Gauss Quadrature rule with k = pi','new fit curve')
title ('Gauss Quadrature rule plot with pi and new fit curve')
hold off
print -depsc2 Gauss_fit_1.eps
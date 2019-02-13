function [B1,B2]=RK4leader(t,Gama1,mm,nn)
% mm is the initial value for Bird leader of its initial x-coordinate
% nn is the initial value for Bird leader of its initial y-coordinate
n = length(t)-1;
h = (t(length(t)) - t(1))/(length(t)-1);
B1 = zeros(size(t));
B2 = zeros(size(t)); %to pre-allocate a vector for the solution
B1(1) = mm;           %to set the initial solution at t=0
B2(1) = nn;

f1 = @(t,B1) Gama1*(2*cos(t)-B1);
f2 = @(t,B2) Gama1*(2*sin(t)-B2);
for i=1:n
   K1x = f1(t(i),B1(i));
   K1y = f2(t(i),B2(i));
   
   K2x = f1(t(i)+0.5*h,B1(i)+0.5*h*K1x);
   K2y = f2(t(i)+0.5*h,B2(i)+0.5*h*K1y);
   
   K3x = f1(t(i)+0.5*h,B1(i)+0.5*h*K2x);
   K3y = f2(t(i)+0.5*h,B2(i)+0.5*h*K2y);
   
   K4x = f1(t(i)+h,B1(i)+h*K3x);
   K4y = f2(t(i)+h,B2(i)+h*K3y);
   
   B1(i+1)=B1(i)+(1/6)*h*(K1x+2*K2x+2*K3x+K4x);
   B2(i+1)=B2(i)+(1/6)*h*(K1y+2*K2y+2*K3y+K4y);
end
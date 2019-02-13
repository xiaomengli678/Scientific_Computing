function [B1,B2]=RK4other(t,Gama2,Gama3,B_leader,Binital_other,Rho,Delta,Kappa)
% mm is the initial value for Bird leader of its initial x-coordinate
% nn is the initial value for Bird leader of its initial y-coordinate
n = length(t)-1;
h = (t(length(t)) - t(1))/(length(t)-1);
B1 = zeros(length(Binital_other)/2,length(t));
B2 = zeros(length(Binital_other)/2,length(t));

B1(:,1) = Binital_other(1:length(Binital_other)/2,:);
B2(:,1) = Binital_other(length(Binital_other)/2+1:length(Binital_other),:);

f1 = @(i,Bx,t) Gama2*(B_leader(1,i)-Bx) + Kappa*(mean([B_leader(1,i);B1(:,i)])-Bx) + Rho*(Bx-(sum(B1(:,i))-Bx)/(Bx-(sum(B1(:,i))-Bx)^2 + Delta)) + Gama3*(Bx-2.1*cos(t));
f2 = @(i,By,t) Gama2*(B_leader(2,i)-By) + Kappa*(mean([B_leader(2,i);B2(:,i)])-By) + Rho*(By-(sum(B2(:,i))-By)/(By-(sum(B2(:,i))-By)^2 + Delta)) + Gama3*(By-2.1*sin(t));
for j= 1:n
    for i = 1:size(B1,1)
   K1x = f1(j,B1(i,j),t(j));
   K1y = f2(j,B2(i,j),t(j));
   B1(i,j+1)  = B1(i,j) + h*K1x;
   B2(i,j+1)  = B2(i,j) + h*K1y;
%    K2x = f1(j+0.5*h,B1(i,j)+0.5*h*K1x);
%    K2y = f2(j+0.5*h,B2(i,j)+0.5*h*K1y);
%    
%    K3x = f1(j+0.5*h,B1(i,j)+0.5*h*K2x);
%    K3y = f2(j+0.5*h,B2(i,j)+0.5*h*K2y);
%    
%    K4x = f1(j+h,B1(i,j)+h*K3x);
%    K4y = f2(j+h,B2(i,j)+h*K3y);
   
%    B1(i,j+1)=B1(i,j)+(1/6)*h*(K1x+2*K2x+2*K3x+K4x);
%    B2(i,j+1)=B2(i,j)+(1/6)*h*(K1y+2*K2y+2*K3y+K4y);
    end
end
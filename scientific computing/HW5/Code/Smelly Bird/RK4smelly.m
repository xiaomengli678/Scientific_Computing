function [B1,B2,B3,B4]=RK4smelly(t,Gama2,B_leader,Binital_other,Binital_smelly,Rho1,Rho2,Delta,Kappa)
% mm is the initial value for Bird leader of its initial x-coordinate
% nn is the initial value for Bird leader of its initial y-coordinate
n = length(t)-1;
h = (t(length(t)) - t(1))/(length(t)-1);
B1 = zeros(length(Binital_other)/2,length(t));
B2 = zeros(length(Binital_other)/2,length(t));

B3 = zeros(length(Binital_smelly)/2,length(t));
B4 = zeros(length(Binital_smelly)/2,length(t));

B1(:,1) = Binital_other(1:length(Binital_other)/2,:);
B2(:,1) = Binital_other(length(Binital_other)/2+1:length(Binital_other),:);

B3(:,1) = Binital_smelly(1:length(Binital_smelly)/2,:);
B4(:,1) = Binital_smelly(length(Binital_smelly)/2+1:length(Binital_smelly),:);

f1 = @(i,Bx) Gama2*(B_leader(1,i)-Bx) + Kappa*(mean([B_leader(1,i);B1(:,i)])-Bx) + Rho1*(Bx-(sum(B1(:,i))-Bx)/(Bx-(sum(B1(:,i))-Bx)^2 + Delta))+ Rho2*(Bx-B3(i))/((Bx-B3(i))^2 + Delta);
f2 = @(i,By) Gama2*(B_leader(2,i)-By) + Kappa*(mean([B_leader(2,i);B2(:,i)])-By) + Rho1*(By-(sum(B2(:,i))-By)/(By-(sum(B2(:,i))-By)^2 + Delta))+ Rho2*(By-B4(i))/((By-B4(i))^2 + Delta);

f3 = @(i,Bx) Gama2*(B_leader(1,i)-Bx) + Kappa*(mean([B_leader(1,i);B1(:,i)])-Bx) + Rho1*(Bx-(sum([B1(:,i);B3(i)])-Bx)/(Bx-(sum([B1(:,i);B3(i)])-Bx)^2 + Delta));
f4 = @(i,By) Gama2*(B_leader(2,i)-By) + Kappa*(mean([B_leader(2,i);B2(:,i)])-By) + Rho1*(By-(sum([B2(:,i);B4(i)])-By)/(By-(sum([B2(:,i);B4(i)])-By)^2 + Delta));

for j= 1:n
    for i = 1:size(B1,1)
   K1x = f1(j,B1(i,j));
   K1y = f2(j,B2(i,j));
   B1(i,j+1)  = B1(i,j) + h*K1x;
   B2(i,j+1)  = B2(i,j) + h*K1y;
   
   KSx = f3(j,B3(j));
   KSy = f4(j,B4(j));
   B3(j+1)  = B3(j) + h*KSx;
   B4(j+1)  = B4(j) + h*KSy;
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
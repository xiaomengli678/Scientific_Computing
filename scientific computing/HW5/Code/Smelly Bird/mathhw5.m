clc
clear all
%% Give a function for C(x,y) for feeder
t = linspace(1,10,50);
t = t';
N = 5;
C = [2*cos(t),2*sin(t)];
Gama1 = 3;
Gama2 = 2;
Rho1 = 2.5;
Rho2 = 10;
Delta = 0.5;
Kappa = 1;

%% Initial Values for Birds 1(leader), 2, 3, 4, 5,,, N.
B = zeros(N*2,size(t,1));
B(1,1) = 0.5; B(2,1) = 0.6;B(3,1) = 0.55; B(4,1) = 0.57;B(5,1) = 0.58;
B(6,1) = 0.5; B(7,1) = 0.6;B(8,1) = 0.55; B(9,1) = 0.57;B(10,1) = 0.58;

%% Add a smelly bird
BS = zeros(2,size(t,1));
BS(1,1) = 0.55; BS(2,1) = 0.55;

%% Assign positions for leader
for j = 2:size(B,2)
    [B1,B2] = RK4leader(t,Gama1,B(1,1),B(N+1,1));
    B(1,j) = B1(j);B(N+1,j) = B2(j);
end

Binital_other = [B(2,1); B(3,1); B(4,1); B(5,1); B(7,1); B(8,1); B(9,1); B(10,1)]; 
B_leader = [B(1,:);B(N+1,:)];

Binital_smelly = [BS(1,1);BS(2,1)];
%% Assign positions for others
[B3,B4,BSx,BSy] = RK4smelly(t,Gama2,B_leader,Binital_other,Binital_smelly,Rho1,Rho2,Delta,Kappa);
B(2:N,:) = B3; B(N+2:2*N,:) = B4;

MakeVideo(t,[B(1:N,:);BSx],[B(N+1:2*N,:);BSy]);

figure
plot(B1,B2,'k*')
hold on
plot(B3(1,:),B4(1,:),'r+');
hold on
plot(B3(2,:),B4(2,:),'bs');
hold on
plot(B3(3,:),B4(3,:),'go');
hold on
plot(B3(4,:),B4(4,:),'mh');
hold on 
plot(BSx,BSy,'yp');
hold off
xlabel('x location','FontSize', 20)
ylabel('y location','FontSize', 20)
legend({'leader', 'Bird2', 'Bird3','Bird4','Bird5','smelly bird'},'FontSize', 25)
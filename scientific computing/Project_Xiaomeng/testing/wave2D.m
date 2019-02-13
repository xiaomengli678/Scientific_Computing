clear all

NX=[21 41 81 161 321]; %an increasing sequence of the number of grid points
E=zeros(size(NX)); H=zeros(size(NX)); %pre-allocation of memory

for kk=1:length(NX)
nx=NX(kk);
ny=nx;             %equal number of grid points in x and y directions
hx=2/(nx-1);       %grid length in x direction
hy=2/(ny-1);       %grid length in y direction
H(kk)=hx;
x=(-1:hx:1);
y=(-1:hy:1)';

t_final=1;
dt=0.5*hx;
nt = floor(t_final/dt)+1;
dt = t_final/nt;

w=10; kx=6; ky=4;

%Set up initial data and obtain u0 and u1
u0=u_exact(0,x,y,w,kx,ky);
f2=f2_fun(x,y,w,kx,ky);
L=laplac(u0,hx,hy,nx,ny);
f=forcing(0,x,y,w,kx,ky);
u1=u0+dt*f2+0.5*(dt^2)*(L+f);

%update BC
u1(1,:)=u_exact(dt,x,-1,w,kx,ky);
u1(ny,:)=u_exact(dt,x,1,w,kx,ky);
u1(:,1)=u_exact(dt,-1,y,w,kx,ky);
u1(:,nx)=u_exact(dt,1,y,w,kx,ky);

for k=0:nt-2
    t=(k+1)*dt;
    %obtin right hand side
    f=forcing(t,x,y,w,kx,ky);
    L=laplac(u1,hx,hy,nx,ny);
    %March in time
    u2=2*u1-u0+(dt^2)*(L+f);
    %update BC
    u2(1,:)=u_exact(t+dt,x,-1,w,kx,ky);
    u2(ny,:)=u_exact(t+dt,x,1,w,kx,ky);
    u2(:,1)=u_exact(t+dt,-1,y,w,kx,ky);
    u2(:,nx)=u_exact(t+dt,1,y,w,kx,ky);
    %switch solution at different time levels
    u0=u1;
    u1=u2;
end
%compute the error
u_ex_final=u_exact(t_final,x,y,w,kx,ky);
E(kk)=max(max(abs(u2-u_ex_final)));
end

E
H
%figure
%surf(x,y,u2); shading interp

%figure
%loglog(H,E,'o-',H,H.^2,'r')
%legend('\epsilon(h)','h^2')
%xlabel('h')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function u=u_exact(t,x,y,w,kx,ky)
u=sin(w*t-kx*x)'*sin(ky*y)';
u=u';
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function f=f2_fun(x,y,w,kx,ky)
f=w*cos(kx*x)'*sin(ky*y)';
f=f';
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function force=forcing(t,x,y,w,kx,ky)
force=-(w^2-kx^2-ky^2)*sin(w*t-kx*x)'*sin(ky*y)';
force=force';
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function L=laplac(u,hx,hy,nx,ny)
L=zeros(size(u));
for j=2:ny-1
    I=2:nx-1;
    L(j,I)=(1/hx^2)*u(j,I+1)+(1/hx^2)*u(j,I-1)+(1/hy^2)*u(j+1,I)+(1/hy^2)*u(j-1,I)-((2/hx^2)+(2/hx^2))*u(j,I);
end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


clear all

nx=5
ny=nx;             %equal number of grid points in x and y directions
hx=2/(nx-1)       %grid length in x direction
hy=2/(ny-1)       %grid length in y direction
x=(-1:hx:1)
y=(-1:hy:1)'

w=10
kx=6
ky=4

%Set up initial data and obtain u0 and u1
f2=f2_fun(x,y,w,kx,ky)

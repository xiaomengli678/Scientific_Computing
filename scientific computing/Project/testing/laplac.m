%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function L=laplac(u,hx,hy,nx,ny)
L=zeros(size(u));
for j=2:ny-1
    I=2:nx-1;
    L(j,I)=(1/hx^2)*u(j,I+1)+(1/hx^2)*u(j,I-1)+(1/hy^2)*u(j+1,I)+(1/hy^2)*u(j-1,I)-((2/hx^2)+(2/hx^2))*u(j,I);
end
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function f=f2_fun(x,y,w,kx,ky)
f=w*cos(kx*x)'*sin(ky*y)';
f=f';
end

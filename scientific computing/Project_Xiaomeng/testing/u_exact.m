%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function u=u_exact(t,x,y,w,kx,ky)
iux=sin(w*t-kx*x)';
iuy=sin(ky*y)';
u=iux*iuy;
u=u';
end


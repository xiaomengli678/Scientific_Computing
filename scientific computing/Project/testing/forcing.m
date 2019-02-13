%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function force=forcing(t,x,y,w,kx,ky)
force=-(w^2-kx^2-ky^2)*sin(w*t-kx*x)'*sin(ky*y)';
force=force';
end

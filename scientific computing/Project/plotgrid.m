clear all;
close all;


load errVal.txt;
load h_eff.txt;
h1=loglog(h_eff,errVal,'r-');
hold on;
hsquared=h_eff.^2;
h2=loglog(h_eff,hsquared,'k--');
ylabel('maximum error');
xlabel('effective h');
legend([h1,h2],'maximum err','h^2');
axis equal;
print -djpeg max.jpg;
%print -depsc2 max.eps;

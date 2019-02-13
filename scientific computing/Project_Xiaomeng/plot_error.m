%clear all;
%close all;


load E.txt;
load H.txt;

h1 = loglog(H,E,'r-');
hold on;
hsquared=H.^2;
h2=loglog(H,hsquared,'k--');
ylabel('maximum error','FontSize', 24);
xlabel('effective h','FontSize', 24);
legend({'maximum err','h^2'},'FontSize', 24,'Location','SouthEast');
set(gca,'FontSize',22);
axis equal;
print -djpeg max.jpg;
%print -depsc2 max.eps;
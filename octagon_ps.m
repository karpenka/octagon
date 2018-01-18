function octagon_ps()
%if you want to change something, look for a_max,a_min,a_step(for size of
%octagon) and the same for L - length of the guide and you need change dir
%in mcstas part of the function

%guide parameters for geks function
w = 0.03;
h = 0.2;
L1 = 10;
a = 0.15;
b = a/sqrt(2);
i=1;
j=1;
%Screw param
L0_min=10;
L0_max=40;
L0_step=1;
%loop
lr=1;
for L0 = L0_min:L0_step:L0_max
    geks_ps(a,b,w,h,L0,L1);
    rect(w,h,2*L0+L1);
    [p0,m0]=mcstas('screw_str.instr',struct('L',2*L0+L1,'guide_m',6,'w',0.03,'h',0.2),struct('ncount',1e5));
    [p1,m1]=mcstas('LIRA_oct.instr',struct('L0',L0,'L1',L1,'guide_m',6,'w',0.03,'h',0.2),struct('ncount',1e5));
    p0=p0.Signal;
    p1=p1.Signal;
    I(lr) = p1/p0;
    lr=lr+1;
end
dlmwrite('octagon.dat',I,' ');
L0 = L0_min:L0_step:L0_max;
plot(L0,I)
% aa=a_min:a_step:a_max;
% LL=L_min:L_step:L_max;
% BB=b_min:b_step:b_max;
% [X,Y]=meshgrid(aa,LL);
% [X,Y]=meshgrid(aa,BB);
% for L=L_min:L_step:L_max
% figure;
% surf(X,Y,I)
% savefig('plot.fig');
% end

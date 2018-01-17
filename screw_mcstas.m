function screw_mcstas()
%if you want to change something, look for a_max,a_min,a_step(for size of
%octagon) and the same for L - length of the guide and you need change dir
%in mcstas part of the function

%guide parameters for geks function
w=0.03;
h=0.2;
f=-2;
i=1;
j=1;
%loop
lr=1;
L_min = 10/45;
L_step = 5/45;
L_max = 100/45;
for L = L_min:L_step:L_max
    screw(w,h,L,f);
    rect(w,h,L*45);
    [p0,m0]=mcstas('screw_str.instr',struct('L',L*45,'guide_m',6,'w',0.03,'h',0.2),struct('ncount',1e5));
    [p1,m1]=mcstas('screw.instr',struct('L',L,'guide_m',6,'w',0.03,'h',0.2,'phi',f),struct('ncount',1e5));
    p0=p0.Signal;
    p1=p1.Signal;
    I(lr) = p1/p0;
    lr=lr+1;
end
% phi_min = 0;
% phi_step = 0.1;
% phi_max = 2;
% L = 0.5;
% for f = phi_min:phi_step:phi_max
%     screw(w,h,L,f);
%     rect(w,h,L*45);
%     [p0,m0]=mcstas('screw_str.instr',struct('L',L*45,'guide_m',6,'w',0.03,'h',0.2),struct('ncount',1e5));
%     [p1,m1]=mcstas('screw.instr',struct('L',L,'guide_m',6,'w',0.03,'h',0.2,'phi',f),struct('ncount',1e5));
%     p0=p0.Signal;
%     p1=p1.Signal;
%     I(lr) = p1/p0;
%     lr=lr+1;
% end
dlmwrite('screw.dat',I,' ');
% f = phi_min:phi_step:phi_max;
% plot(f,I);
L = L_min:L_step:L_max;
plot(L,I)
% aa=a_min:a_step:a_max;
% [X,Y]=meshgrid(aa,LL);
% for L=L_min:L_step:L_max
% figure;
% surf(X,Y,I)
% savefig('plot.fig');
end
function screw_mcstas(w,h,L)
%if you want to change something, look for a_max,a_min,a_step(for size of
%octagon) and the same for L - length of the guide and you need change dir
%in mcstas part of the function

%guide parameters for geks function
%w=0.03;
%h=0.2;
i=1;
j=1;
%Screw param
L_min=10;
L_max=40;
L_step=1;
[p0s,m0s]=mcstas('screw_str.instr',struct('L',L,'lambda',5,'guide_m',6,'w',0.03,'h',0.2),struct('ncount',1e5,'dir','/home/','overwrite',1, 'mpi',4));
[p0,m0]=mcstas('screw.instr',struct('L',L,'lambda',5,'guide_m',6,'w',0.03,'h',0.2),struct('ncount',1e5,'dir','/home/','overwrite',1, 'mpi',4));
p0s=p0s.Signal;
p0=p0.Signal;
diff = p0/p0s;
%loop
progressbar('a','L');
k=1;
l=1;
lr=1;
for L = L_min:L_step:L_max
    screw(w,h,2*L);
    [p1,m2]=mcstas('screw_str.instr',struct('',2*L,'lambda',5,'guide_m',6),struct('ncount',1e5,'dir','/home/konik/Downloads/new/test','overwrite',1, 'mpi',4));
    [p2,m2]=mcstas('screw.instr',struct('',2*L,'lambda',5,'guide_m',6),struct('ncount',1e5,'dir','/home/konik/Downloads/new/test','overwrite',1, 'mpi',4));
    p1=p1.Signal;
    p2=p2.Signal;
    IL(lr) = p1;
    lr=lr+1;
end;
dlmwrite('screw.dat',I,' ');
aa=a_min:a_step:a_max;
[X,Y]=meshgrid(aa,LL);
for L=L_min:L_step:L_max
figure;
surf(X,Y,I)
savefig('plot.fig');
end
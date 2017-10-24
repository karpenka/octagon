function octagon()
%if you want to change something, look for a_max,a_min,a_step(for size of
%octagon) and the same for L - length of the guide and you need change dir
%in mcstas part of the function

%guide parameters for geks function
w=0.03;
h=0.2;
i=1;
j=1;
%octagon param
a_max=0.2;
a_min=0.05;
a_step=0.01;
L_max=30;
L_min=10;
L_step=1;
%R=0.1;
%a=0.1;
%b=0.1;
%loop
progressbar('a','L');
k=1;
l=1;
lr=1;
for L = L_min:L_step:L_max
    rect(w,h,2*L);
    [p1,m]=mcstas('LIRA_str.instr',struct('octa_length',2*L,'lambda',5,'guide_m',6),struct('ncount',1e5,'dir','/home/konik/Downloads/new/test','overwrite',1, 'mpi',4));
    p1=p1.Signal;
    IL(lr) = p1;
    lr=lr+1;
end;
for a = a_min:a_step:a_max 
%for b = b_min:b_step:b_max
for L = L_min:L_step:L_max
    pause(0.001) 
    geks_ang(a,w,h,L);
    %geks_ang(R,w,h,L);
    [p0,m]=mcstas('LIRA_oct.instr',struct('octa_length',2*L,'lambda',5,'guide_m',6),struct('ncount',1e5,'dir','/home/konik/Downloads/new/test','overwrite',1,'mpi',4));
    %/home/student/mirror/Kireenko/Dropbox/matlab/octagon/temp/geks_2.m
    %'mpi',4
    p=p0.Signal;
    I(k,l)=p/IL(l);
    frac1 = ((a-a_min)/a_step+1)/((a_max-a_min)/a_step+1);
    %frac2 = ((b-b_min)/b_step+1)/((b_max-b_min)/b_step+1);
    frac2 = ((L-L_min)/L_step+1)/((L_max-L_min)/L_step+1);
    progressbar(frac1, frac2);
    l=l+1;
end;
    k=k+1;
    l=1;
end;
dlmwrite('octagon.dat',I,' ');
aa=a_min:a_step:a_max;
LL=L_min:L_step:L_max;
%BB=b_min:b_step:b_max;
[X,Y]=meshgrid(aa,LL);
%[X,Y]=meshgrid(aa,BB);
for L=L_min:L_step:L_max
figure;
surf(X,Y,I)
savefig('plot.fig');
end

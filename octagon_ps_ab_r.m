function octagon_ps_ab_r(lambda,varargin)
%parameters varargin -> f = -2, m = 6, ncount = 1e5
numvarargs = length(varargin);
if numvarargs > 3
    error('myfuns:TooManyInputs', ...
        'requires at most 3 optional inputs');
end
% set defaults for optional inputs
optargs = {6 1e5};
% now put these defaults into the valuesToUse cell array, 
% and overwrite the ones specified in varargin.
optargs(1:numvarargs) = varargin;
% or ...
% [optargs{1:numvarargs}] = varargin{:};

% Place optional args in memorable variable names
[m, ncount] = optargs{:};
%guide parameters for geks function)
%if you want to change something, look for a_max,a_min,a_step(for size of
%octagon) and the same for L - length of the guide and you need change dir
%in mcstas part of the function

%guide parameters for geks function
w = 0.03;
h = 0.1;
L1 = 40;
L0 = 40;
% a = 0.15;
% b = a/sqrt(2);
a_min = 0.01;
a_step = 0.01;
a_max = 0.21;
b_min = 0.01;
b_step = 0.01;
b_max = 0.21;
i=1;
j=1;
%Screw param
%loop
k=1;
l=1;
lr=1;
rect(w,h,2*L0+L1);
[p0,m0]=mcstas('screw_str.instr',struct('lambda',lambda,'L',2*L0+L1,'guide_m',m,'w',w,'h',h),struct('ncount',ncount,'mpi',4));
p0l=p0(1,:,:).Signal;
p0m=p0(2,:,:).Signal;
p0s=p0(3,:,:).Signal;
I0l(lr) = p0l;
I0m(lr) = p0m;
I0s(lr) = p0s;

progressbar('a','b');
for a = a_min:a_step:a_max
for b = b_min:b_step:b_max
    pause(0.0001)
    geks_ps_rotated(a,b,w,h,L0,L1);
    [p1,m1]=mcstas('LIRA_oct.instr',struct('lambda',lambda,'L0',L0,'L1',L1,'guide_m',m,'w',w,'h',h),struct('ncount',ncount,'mpi',4));
    p1l=p1(1,:,:).Signal;
    p1m=p1(2,:,:).Signal;
    p1s=p1(3,:,:).Signal;
    Il(l,k)=p1l/I0l;
    Im(l,k)=p1m/I0m;
    Is(l,k)=p1s/I0s;
    frac1 = ((a-a_min)/a_step+1)/((a_max-a_min)/a_step+1);
    frac2 = ((b-b_min)/b_step+1)/((b_max-b_min)/b_step+1);
    progressbar(frac1, frac2);
    l=l+1;
end
    k=k+1;
    l=1;
end

dlmwrite(join([join(['oct_ab_r','lambda',string(lambda),'l'],'_'),'.dat'],''),Il,' ');
dlmwrite(join([join(['oct_ab_r','lambda',string(lambda),'m'],'_'),'.dat'],''),Im,' ');
dlmwrite(join([join(['oct_ab_r','lambda',string(lambda),'s'],'_'),'.dat'],''),Is,' ');
aa=a_min:a_step:a_max;
bb=b_min:b_step:b_max;
[X,Y]=meshgrid(aa,bb);
figure;
surf(X,Y,Il)
xlabel('a [m]')
ylabel('b [m]')
zlabel('I_{oct}/I_{str}')
title(join(['Divergence = \pm1.5\circ, ','lambda = ',string(lambda)]))
savefig(join(['oct_ab_r','lambda',string(lambda),'l'],'_'));
figure;
surf(X,Y,Im)
xlabel('a [m]')
ylabel('b [m]')
zlabel('I_{oct}/I_{str}')
title(join(['Divergence = \pm0.5\circ, ','lambda = ',string(lambda)]))
savefig(join(['oct_ab_r','lambda',string(lambda),'m'],'_'));
figure;
surf(X,Y,Is)
xlabel('a [m]')
ylabel('b [m]')
zlabel('I_{oct}/I_{str}')
title(join(['Divergence = \pm0.1\circ, ','lambda = ',string(lambda)]))
savefig(join(['oct_ab_r','lambda',string(lambda),'s'],'_'));
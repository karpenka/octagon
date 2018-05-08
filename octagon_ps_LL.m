function octagon_ps_LL(lambda,varargin)
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
a = 0.05;
b = 0.05;
L_min = 5;
L_step = 20;
L_max = 105;
i=1;
j=1;
%Screw param
%loop
k=1;
l=1;
lr=1;
% for L = L_min:L_step:L_max
%     rect(w,h,L);
%     [p0,m0]=mcstas('screw_str.instr',struct('lambda',lambda,'L',L,'guide_m',m,'w',w,'h',h),struct('ncount',ncount));
%     p0l=p0(1,:,:).Signal;
%     p0m=p0(2,:,:).Signal;
%     p0s=p0(3,:,:).Signal;
%     I0l(lr) = p0l;
%     I0m(lr) = p0m;
%     I0s(lr) = p0s;
%     lr=lr+1;
% end
rect(w,h,32);
[p0,m0]=mcstas('screw_str.instr',struct('lambda',lambda,'L',32,'guide_m',m,'w',w,'h',h),struct('ncount',ncount));
p0l=p0(1,:,:).Signal;
p0m=p0(2,:,:).Signal;
p0s=p0(3,:,:).Signal;
I0l = p0l;
I0m = p0m;
I0s = p0s;
progressbar('L0','L1');
for L = L_min:L_step:L_max
    L1_min = 0.1*L;
    L1_step = 0.1*L;
    L1_max = 0.9*L;
for L1 = L1_min:L1_step:L1_max
    pause(0.0001)
    geks_ps_rotated(a,b,w,h,(L-L1)/2,L1);
    [p1,m1]=mcstas('LIRA_oct.instr',struct('lambda',lambda,'L0',(L-L1)/2,'L1',L1,'guide_m',m,'w',w,'h',h),struct('ncount',ncount));
    p1l=p1(1,:,:).Signal;
    p1m=p1(2,:,:).Signal;
    p1s=p1(3,:,:).Signal;
    Il(l,k) = p1l/I0l;
    Im(l,k) = p1m/I0m;
    Is(l,k) = p1s/I0s;
    frac1 = ((L-L_min)/L_step+1)/((L_max-L_min)/L_step+1);
    frac2 = ((L1-L1_min)/L1_step+1)/((L1_max-L1_min)/L1_step+1);
    progressbar(frac1, frac2);
    l=l+1;
end
    k=k+1;
    l=1;
end   

progressbar('a','b');


dlmwrite(join([join(['oct_LL','lambda',string(lambda),'l'],'_'),'.dat'],''),Il,' ');
dlmwrite(join([join(['oct_LL','lambda',string(lambda),'m'],'_'),'.dat'],''),Im,' ');
dlmwrite(join([join(['oct_LL','lambda',string(lambda),'s'],'_'),'.dat'],''),Is,' ');
LL = L_min:L_step:L_max;
LL1 = 0.1:0.1:0.9;
[X,Y]=meshgrid(LL,LL1);
figure;
surf(X,Y,Il)
savefig(join(['oct_LL','lambda',string(lambda),'l'],'_'));
figure;
surf(X,Y,Im)
savefig(join(['oct_LL','lambda',string(lambda),'m'],'_'));
figure;
surf(X,Y,Is)
savefig(join(['oct_LL','lambda',string(lambda),'s'],'_'));
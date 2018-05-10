function screw_mcstas(lambda,varargin)
%parameters varargin -> f = -2, m = 6, ncount = 1e5
numvarargs = length(varargin);
if numvarargs > 3
    error('myfuns:TooManyInputs', ...
        'requires at most 3 optional inputs');
end
% set defaults for optional inputs
optargs = {-2 6 1e5};
% now put these defaults into the valuesToUse cell array, 
% and overwrite the ones specified in varargin.
optargs(1:numvarargs) = varargin;
% or ...
% [optargs{1:numvarargs}] = varargin{:};

% Place optional args in memorable variable names
[f, m, ncount] = optargs{:};
%guide parameters for geks function
w = 0.03;
h = 0.2;
i = 1;
j = 1;
%loop
lr = 1;
L_min = 5/45;
L_step = 5/45;
L_max = 50/45;
for L = L_min:L_step:L_max
    screw(w,h,L,f);
    rect(w,h,L*45);
    [p0,m0]=mcstas('screw_str.instr',struct('L',L*45,'lambda',lambda,'guide_m',m,'w',w,'h',h),struct('ncount',ncount,'mpi',4));
    [p1,m1]=mcstas('screw.instr',struct('L',L,'lambda',lambda,'guide_m',m,'w',w,'h',h,'phi',f),struct('ncount',ncount,'mpi',4));
    p0l=p0(1,:,:).Signal;
    p1l=p1(1,:,:).Signal;
    Il(lr) = p1l/p0l;
    p0m=p0(2,:,:).Signal;
    p1m=p1(2,:,:).Signal;
    Im(lr) = p1m/p0m;
    p0s=p0(3,:,:).Signal;
    p1s=p1(3,:,:).Signal;
    Is(lr) = p1s/p0s;
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
% f = phi_min:phi_step:phi_max;
% plot(f,I);
L = L_min*45:L_step*45:L_max*45;
dlmwrite(join([join(['screw','lambda',string(lambda),'l'],'_'),'.dat'],''),Il,' ');
dlmwrite(join([join(['screw','lambda',string(lambda),'m'],'_'),'.dat'],''),Im,' ');
dlmwrite(join([join(['screw','lambda',string(lambda),'s'],'_'),'.dat'],''),Is,' ');
figure;
plot(L,Il)
xlabel('Length [m]')
ylabel('I_{screw}/I_{straight}')
title(join(['Divergence = \pm1.5\circ, ','lambda = ',string(lambda)]))
grid on
savefig(join(['screw','lambda',string(lambda),'l'],'_'));
figure;
plot(L,Im)
xlabel('Length [m]')
ylabel('I_{screw}/I_{straight}')
title(join(['Divergence = \pm0.5\circ, ','lambda = ',string(lambda)]))
grid on
savefig(join(['screw','lambda',string(lambda),'m'],'_'));
figure;
plot(L,Is)
xlabel('Length [m]')
ylabel('I_{screw}/I_{straight}')
title(join(['Divergence = \pm0.1\circ, ','lambda = ',string(lambda)]))
grid on
savefig(join(['screw','lambda',string(lambda),'s'],'_'));
% aa=a_min:a_step:a_max;
% [X,Y]=meshgrid(aa,LL);
% for L=L_min:L_step:L_max
% figure;
% surf(X,Y,I)
% savefig('plot.fig');
end
function geks_ang(R,w,h,L)
%a - side of geks, w - width, h - height, L - length
x0=['OFF'];
x1=[12 8 0;...
w/2 h/2 0;...
-w/2 h/2 0;...
-w/2 -h/2 0;...
w/2 -h/2 0;...
R/sqrt(2) R/sqrt(2) L;...
0 R L;...
-R/sqrt(2) R/sqrt(2) L;...
-R 0 L;...
-R/sqrt(2) -R/sqrt(2) L;...
0 -R L;...
R/sqrt(2) -R/sqrt(2) L;...
R 0 L];
%x2=[4 2 1 4 5;...
%4 2 3 7 6;...
%4 3 0 8 9;...
%4 0 1 11 10];
x3=[3 1 0 5;...
3 1 5 6;...
3 2 1 7;...
3 7 8 2;...
3 8 9 2;...
3 9 10 3;...
3 9 2 3;...
3 10 11 3;...
3 11 4 0;...
3 11 0 3;...
3 5 4 0
3 7 1 2];
dlmwrite('geks.off',x0,'')
dlmwrite('geks.off',x1,'-append','delimiter',' ')
%dlmwrite('geks.off',x2,'-append','delimiter',' ')
dlmwrite('geks.off',x3,'-append','delimiter',' ')
end

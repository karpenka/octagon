function geks_ab(a,b,w,h,L)
%a - side of geks, w - width, h - height, L - length
x0=['OFF'];
x1=[12 8 0;...
w/2 -h/2 0;...
w/2 h/2 0;...
-w/2 h/2 0;...
-w/2 -h/2 0;...
a/2 b/2 L;...
-a/2 b/2 L;...
-b/2 a/2 L;...
-b/2 -a/2 L;...
-a/2 -b/2 L;...
a/2 -b/2 L;...
b/2 -a/2 L;...
b/2 a/2 L];
x2=[4 2 1 4 5;...
4 2 3 7 6;...
4 3 0 8 9;...
4 0 1 11 10];
x3=[3 1 4 11;...
3 0 9 10;...
3 3 7 8;...
3 2 6 5];
dlmwrite('geks.off',x0,'')
dlmwrite('geks.off',x1,'-append','delimiter',' ')
dlmwrite('geks.off',x2,'-append','delimiter',' ')
dlmwrite('geks.off',x3,'-append','delimiter',' ')
end
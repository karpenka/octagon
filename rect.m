function rect(w,h,L)
%a - side of geks, w - width, h - height, L - length
x0=['OFF'];
x1=[8 4 0;...
-w/2 -h/2 0;...
-w/2 h/2 0;...
w/2 h/2 0;...
w/2 -h/2 0;...
 -w/2 -h/2 L;...
-w/2 h/2 L;...
w/2 h/2 L;...
w/2 -h/2 L];
x2=[4 0 1 5 4;...
4 1 2 6 5;...
4 2 6 7 3;...
4 3 7 4 0];
dlmwrite('rectangle.off',x0,'')
dlmwrite('rectangle.off',x1,'-append','delimiter',' ')
dlmwrite('rectangle.off',x2,'-append','delimiter',' ')
end

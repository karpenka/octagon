function screw(w,h,L,f)
%f - angle, w - width, h - height, L - length
x0=['OFF'];
x1=[8 4 0;...
-w/2 h/2 0;...
w/2 h/2 0;...
-w/2 -h/2 0;...
w/2 -h/2 0;...
-(h/2*sin(f)+w/2*cos(f)) h/2*cos(f)-w/2*sin(f) L;...
-(h/2*sin(f)-w/2*cos(f)) h/2*cos(f)+w/2*sin(f) L;...
(h/2*sin(f)+w/2*cos(f)) -(h/2*cos(f)-w/2*sin(f)) L;...
(h/2*sin(f)-w/2*cos(f)) -(h/2*cos(f)+w/2*sin(f)) L];
x2=[4 0 1 5 4;...
4 0 2 6 4;...
4 2 3 7 6;...
4 1 3 7 5];
dlmwrite('screw.off',x0,'')
dlmwrite('screw.off',x1,'-append','delimiter',' ')
dlmwrite('screw.off',x2,'-append','delimiter',' ')
end
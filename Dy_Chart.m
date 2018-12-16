function h = Dy_Chart(h,i,t1,m1,x)
global Plot_vector
global round_Num
t1=[t1,i];
m1=[m1,Plot_vector(1)];
set(h,'xdata',t1,'ydata',m1);
drawnow
x=x+1;
axis([x x+1 0 2*round_Num]);
end


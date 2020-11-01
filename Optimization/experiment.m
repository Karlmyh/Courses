syms x1 x2
f=100*(x2-x1^2)^2+(1-x1)^2;


[x, value ,iteration]=steepest(f,[-2;-2],1e-3,"backprop")
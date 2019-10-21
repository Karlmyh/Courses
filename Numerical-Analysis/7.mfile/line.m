function result= line(x,c)
if nargin<2
    c=-5:5;
end
c=sort(c);
index=find(sort([c,x])==x);
index=index(1)-1;
result= (f(c(index+1))-f(c(index)))/(c(index+1)-c(index))*(x-c(index))+f(c(index));
end
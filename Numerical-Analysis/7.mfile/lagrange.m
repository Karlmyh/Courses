function result =lagrange(x,c)
if nargin<2
    c=0:20;
    c=5*cos(pi*(2*c+1)/42);
end
n=length(c)-1;
p=zeros(1,n+1);
for i = 1:n+1
    temp=c;
    temp(i)=[];
    p=p+f(c(i))*poly(temp)/prod(c(i)*ones(1,n)-temp);
end
result=p(1);
for i =2:n+1
    result=result*x+p(i);
end
end

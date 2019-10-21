function result =newton(x,c)
if nargin<2
    c=-5:5;
end
n=length(c)-1;
dq=zeros(n+1);
for i =1:n+1
    dq(i,1)=f(c(i));
end
for j = 2:n+1
    for i= j:n+1
        dq(i,j)=(dq(i,j-1)-dq(i-1,j-1))/(c(i)-c(i-j+1));
    end
end
p=zeros(1,n+1);
p(1,n+1)=dq(1,1);
for i = 2:n+1
    p=p+[zeros(1,n+1-i),dq(i,i)*poly(c(1:i-1))];
end
result=p(1);
for i =2:n+1
    result=result*x+p(i);
end
end

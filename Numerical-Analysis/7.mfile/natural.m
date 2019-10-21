function result = natural(x,c)
if nargin<2
    c=-5:5;
end
n=length(c)-1;
c=sort(c);
index=find(sort([c,x])==x);
index=index(1)-1;
d=zeros(1,n);
h=zeros(1,n);
m=zeros(1,n-1);
for i =1:n
    h(i)=c(i+1)-c(i);
end
for i=2:n
    d(i)=(f(c(i+1))-f(c(i)))/h(i)-(f(c(i))-f(c(i-1)))/h(i-1);
end
d(1)=[];
H=zeros(n-1);
H(1,1)=2*(h(1)+h(2));
for i=2:n-1
   H(i,i)=2*(h(i)+h(i+1));
   H(i,i-1)=h(i);
   H(i-1,i)=h(i);
end
t=zeros(1,n-1);
t(1)=gg(c(1))*h(1)/6;
t(n-1)=gg(c(n+1))*h(n)/6;
m=pursue(H,6*(d-t));
m=[gg(c(1)),m,gg(c(n+1))];
result=((c(index+1)-x)^3*m(index)/6+(x-c(index))^3*m(index+1)/6)/h(index)+f(c(index));
result=result+(x-c(index))*(f(c(index+1))-f(c(index)))/h(index);
result=result-h(index)*h(index)*(1/6)*(m(index)+(m(index+1)-m(index))*(x-c(index))/h(index));
end
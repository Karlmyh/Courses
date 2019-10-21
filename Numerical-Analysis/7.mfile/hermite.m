function result = hermite(x,c)
if nargin<2
    c=floor(x):(1/3):floor(x)+1;
end
n=length(c)-1;
p=zeros(1,2*n+2);
for i=1:n+1
    temp=c;
    temp(i)=[];
    l=poly(temp)/prod(c(i)-temp);
    ls=conv(l,l);
   p=p+f(c(i))* conv([0,1]-2*poly(c(i))*sum((c(i)-temp).^-1),ls);
end
for i=1:n+1
    temp=c;
    temp(i)=[];
    l=poly(temp)*prod((c(i)-temp).^-1);
    ls=conv(l,l);
    p=p+g(c(i))*conv(poly(c(i)),ls);
end
result=p(1);
for i =2:(2*n+2)
    result=result*x+p(i);
end
end
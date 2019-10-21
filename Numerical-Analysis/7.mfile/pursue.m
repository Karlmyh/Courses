function result=pursue(a,b)
n=length(b);
a(1,2)=a(1,2)/a(1,1);
for i = 2:n-1
    a(i,i)=a(i,i)-a(i,i-1)*a(i-1,i);
    a(i,i+1)=a(i,i+1)/a(i,i);
end
a(n,n)=a(n,n)-a(n,n-1)*a(n-1,n);
b(1)=b(1)/a(1,1);
for i = 2:n
   b(i)=(b(i)-a(i,i-1)*b(i-1))/a(i,i); 
end
for i=1:n-1
   b(n-i)=b(n-i)-b(n-i+1)*a(n-i,n-i+1);
end
result=b;
end
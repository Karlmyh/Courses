%function for line search

function[x,value]=linesearch(f,xzero,gradientemp,method)
if(method=="exact")
    n=length(xzero);%dimension
    S=sym("x",[1 n]);%variables
    syms m real
    %the line
    xtemp=xzero+m*gradientemp;
    ftemp=f;
    for i=1:n
        ftemp=subs(ftemp,S(i),xtemp(i));
    end
    % derivative
    h=diff(ftemp,m);
    mtemp=double(solve(h,m,"Real",true));
    %if(subs(h,m,))

    % get smallest stationary point
    k=size(mtemp);
    value=10000000;
    for i=1:(k(1))
        fvalue=subs(ftemp,m,mtemp(i));
        if(fvalue<value)
            value=fvalue;
            x=xzero+mtemp(i)*gradientemp;
            double(x)
        end
    end
end

if(method=="backprop")
    n=length(xzero);%dimension
    S=sym("x",[1 n]);%variables
    syms m real
    %the line
    xtemp=xzero-m*gradientemp;
    ftemp=f;
    for i=1:n
        ftemp=subs(ftemp,S(i),xtemp(i));
    end
    % set max length
    len=0.7;
    rho=0.6 ;
    alpha=0.5;
    while(subs(ftemp,m,len)>subs(ftemp,m,0)-alpha*len*norm(subs(ftemp,m,0)))
        len=len*rho;
    end
    len
    x=xzero-len*gradientemp;
    double(x)
    value=subs(ftemp,m,len);
end


end
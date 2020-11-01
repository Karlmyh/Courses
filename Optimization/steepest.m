%function for gradient descent

function [x, value ,iteration]=steepest(f,xzero,epsilon,method)
    n=size(xzero);%dimension
    S=sym("x",[1 n]);%variables
    %learning rate is useless for exact search
    %syms alpha;
    %gradient function
    gradient=diff(f,S(1));
    for i =2:n
        gradient=[gradient;diff(f,S(i))];
    end
    %initialize
    goon=1;
    iteration=0;
    x=xzero;
    f_temp=f;
    for i=1:n
        f_temp=subs(f_temp,S(i),xzero(i));
    end
    value=f_temp;
    %iteration
    count=1;
    while(goon)
 
        %compute gradient
        gradientemp=gradient;
        for i=1:n
            gradientemp=subs(gradientemp,S(i),x(i));
        end
        %check the gradient length
        gralength=norm(gradientemp);
        if(gralength>epsilon)
            %do line search along x+h*gradient
            
            [x,value]=linesearch(f,x,gradientemp,method);
            count=count+1
            double(x)
            if(norm(x)>1000000)
                goon=0;
            end
            iteration=iteration+1;
        else
            goon=0;
        end
        
        
    end
    
    
    

end
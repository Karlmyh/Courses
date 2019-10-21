#include <iostream>
#include <iomanip>
#include <math.h>
#define Epsilon 0.000001
using namespace std;
int sign(double x){
    if(x>0){return 1;}
    else if(x==0){return 0;}
    else{return -1;}
}
double f(double x){
    return exp(-x)-sin(x);
}
double h(double x){
    return exp(-x)-sin(x)+x;
}
double g(double x){
    return asin(exp(-x));
}
double half(double x){
    double m=x;
    double a=m-1.5,b=m+1.5;
    if(sign(f(a))==sign(f(b))){return 0;}
    else{
        m=a+(b-a)/2;
        if(f(m)==0){return m;}
        else{
        while((a-b)*sign(a-b)>Epsilon){
        if(sign(f(m))==sign(f(a))){a=m;}
        else{b=m;}
            m=a+(b-a)/2;
            //cout<<m<<endl;
        }
            return m;
        }
    }
}
double steffen1(double x){
    double x1=0,x2=x;
    while((x1-x2)*sign(x1-x2)>Epsilon){
        x1=x2;
        x2=x1-(h(x1)-x1)*(h(x1)-x1)/(h(h(x1))-2*h(x1)+x1);
        //cout<<x1<<endl;
    }
        return x2;
    }
double fixedpoint1(double x){
    double x1=0,x2=x;
    while((x1-x2)*sign(x1-x2)>Epsilon){
        x1=x2;
        x2=h(x2);
        //cout<<x1<<endl;
    }
    return x2;
}
double steffen2(double x){
    double x1=0,x2=x;
    while((x1-x2)*sign(x1-x2)>Epsilon){
        x1=x2;
        x2=x1-(g(x1)-x1)*(g(x1)-x1)/(g(g(x1))-2*g(x1)+x1);
        //cout<<x1<<endl;
    }
    return x2;
}
double fixedpoint2(double x){
    double x1=0,x2=x;
    while((x1-x2)*sign(x1-x2)>Epsilon){
        x1=x2;
        x2=g(x2);
        //cout<<x1<<endl;
    }
    return x2;
}
double newton(double x){
    double x1=0,x2=x;
    while((x1-x2)*sign(x1-x2)>Epsilon&&f(x1)!=0){
        x1=x2;
        x2=x1-(exp(-x1)-sin(x1))/(-exp(-x1)-cos(x1));
        //cout<<x1<<endl;
    }
    return x1;
}
double line(double x){
    double temp,x1=x-0.1,x2=x;
    while((x1-x2)*sign(x1-x2)>Epsilon&&f(x1)!=0){
        temp=x2-f(x2)*(x2-x1)/(f(x2)-f(x1));
        x1=x2;
        x2=temp;
        //cout<<x1<<endl;
    }
    return x1;
}
double muller(double x0,double x1,double x2){
    double p,h,a,b,d,e,sigma1,sigma2,h1=x1-x0,h2=x2-x1;
    sigma1=(f(x1)-f(x0))/h1;sigma2=(f(x2)-f(x1))/h2;
    a=(sigma2-sigma1)/(h1+h2);
    while(1){
        b=sigma2+h2*a;
        d=sqrt(b*b-4*f(x2)*a);
        if(sign(b-d)*(b-d)<sign(b+d)*(b+d)){e=b+d;}
        else{e=b-d;}
        h=-2*f(x2)/e;
        p=x2+h;
        if(h*sign(h)>Epsilon)break;
        x0=x1;
        x1=x2;
        x2=p;
        h1=x1-x0;
        sigma1=(f(x1)-f(x0))/h1;
        sigma2=(f(x2)-f(x1))/h2;
        a=(sigma2-sigma1)/(h2+h1);
    }
    return p;
}
double m(double x){
    return (-cos(x)-exp(-x)+sqrt(2*cos(x)*exp(-x)+1))/2/(-sin(x)-exp(-x));
}
double New(double x){
    double x1=0,x2=x;
    while((x1-x2)*sign(x1-x2)>Epsilon&&f(x1)!=0){
        x1=x2;
        x2=x1+m(x1);
        cout<<x1<<endl;
    }
    return x1;
}
int main() {
    for(double x=1;x<100;x=x+1){
        cout<<setprecision(5)<<x<<"\t"<<half(x)<<"\t"<<steffen1(x)<<"\t"<<fixedpoint1(x)<<"\t"<<steffen2(x)<<"\t"<<fixedpoint2(x)<<"\t"<<newton(x)<<"\t"<<line(x)<<"\t"<<muller(x-0.1,x,x+0.1)<<endl;
        
    }
    //cout<<setprecision(10)<<"\t"<<half(0.6)<<"\t"<<steffen1(0.6)<<"\t"<<fixedpoint1(0.6)<<endl;
    //cout<<steffen2(0.6)<<"\t"<<fixedpoint2(0.6)<<"\t"<<newton(0.6)<<"\t"<<line(0.6)<<"\t"<<muller(0.5,0.6,0.7)<<"\t"<<endl;
    //cout<<setprecision(10)<<New(0.6);
    //cout<<muller(0.5,0.6,0.7)<<endl;
    return 0;
}

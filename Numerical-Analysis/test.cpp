#include <iostream>
#include <iomanip>
#include <math.h>
using namespace std;
double f(double x){
    return exp(-10*(x-1)*(x-1));
}
double S(double h,double a=0,double b=1){
    double I=(f(a)+f(b))/3;
    double x=a;
    int n=1;
    while(x+h<b){
        x+=h;
        I=I+2*f(x)/3+2*n*f(x)/3;
        n=1-n;
    }
    return h*I;
}

double self(double a,double b,double epsilon,int *count,double *length){
    if(abs(S((b-a)/2,a,b)-S((b-a)/4,(a+b)/2,b)-S((b-a)/4,a,(a+b)/2))<(b-a)*epsilon/2){
        return S((b-a)/2,a,b);
    }
    else {
        *count=*count+2;
        if((b-a)/2<*length){*length=(b-a)/2;}
        return self((a+b)/2,b,epsilon,count,length)+self(a,(a+b)/2,epsilon,count,length);
    }
}

int main() {
    int count=2;
    double length=1;
        clock_t start=clock();
    cout<<setprecision(10)<<self(-1,1,0.0001,&count,&length)<<endl;
        clock_t end=clock();
    cout<<"time "<<(end-start)<<"ms"<<endl;
    cout<<"number of points "<<count<<endl;
    cout<<"shortest interval "<<length/2<<endl;
    return 0;
}

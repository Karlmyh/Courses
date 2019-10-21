#include <iostream>
#include <iomanip>
#include <math.h>
using namespace std;
#define PI 3.141592653589;
double f(double x){
    if(x==1){return 0;}
    else return 1/cos(x)/cos(x)*pow(tan(x),3)/(exp(tan(x))-1);
}
double T(double h,double a=0,double b=1){
    double I=(f(a)+f(b))/2;
    double x=a;
    while(x+h<b){
        x+=h;
        I=I+f(x);
    }
    return I*h;
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

double half(double epsilon,double a=0,double b=1){
    double I=(f(a)+f(b))/2;
    double temp=-5;
    double h=b-a;
    while(abs(I-temp)>epsilon){
        temp=I;
        I=0.5*I;
        double step=0.5*h;
        while(step<b){
            I=I+0.5*h*f(step);
            step+=h;
        }
        h=0.5*h;
    }
    return I;
}
double romberg(double epsilon,double a=0,double b=1){
    double count[100];//changable
    int n=0;
    double I=(f(a)+f(b))/2;
    count[0]=I;n++;
    double temp=-5;
    double h=b-a;
    while(abs(I-temp)>epsilon){
        temp=I;
        I=0.5*I;
        double step=0.5*h;
        while(step<b){
            I=I+0.5*h*f(step);
            step+=h;
        }
        count[n]=I;n++;
        h=0.5*h;
    }
    n=n-1;
    double T[n][n];
    T[0][0]=(f(a)+f(b))/2;
    for(int i=0;i<n;i++){
        T[i][0]=count[i];
    }
    for(int j=1;j<n;j++){
        for(int i=j;i<n;i++){
            T[i][j]=(pow(4,j)*T[i][j-1]-T[i-1][j-1])/(pow(4,j)-1);
        }
    }
    return T[n-1][n-1];
}
double self(double a,double b,double epsilon){
    if(abs(S((b-a)/2,a,b)-S((b-a)/4,(a+b)/2,b)-S((b-a)/4,a,(a+b)/2))<epsilon){
        return S((b-a)/2,a,b);
    }
    else return self((a+b)/2,b,epsilon)+self(a,(a+b)/2,epsilon);
}
double gausslegendre(double h,double a=0,double b=1){
    double I=0;
    double x=a-h/2;
    while(x+h<b){
        x+=h;
        I=I+h/2*(f(sqrt(3)*h/6+x)+f(-sqrt(3)*h/6+x));
    }
    return I;
}
double cut(double epsilon,double h,int n){
    double I=0;
    double a=epsilon,b=1.5707963267948+epsilon;
    clock_t start=clock();
    if(n==1){I=T(h,a,b);cout<<"T";}
    if(n==2){I=S(h,a,b);cout<<"Simpson";}
    if(n==3){I=half(epsilon,a,b);cout<<"half";}
    if(n==4){I=romberg(epsilon,a,b);cout<<"romberg";}
    if(n==5){I=self(a,b,epsilon);cout<<"self";}
    if(n==6){I=gausslegendre(h,a,b);cout<<"gausslegendre";}
    clock_t end=clock();
    cout<<endl<<"time"<<(end-start)<<endl;
    return I;
}
int main() {
    cout<<setprecision(15)<<cut(0.0000001,0.0001,5)<<endl<<endl;
    for(int i=1;i<7;i++){
        if(i==3)continue;
        cout<<setprecision(15)<<cut(0.0000001,0.0001,i)<<endl<<endl;}
    return 0;
}

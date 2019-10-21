#include <iostream>
#include <math.h>
using namespace std;
#define Epsilon 0.000001
int sign(double x){
    if(x>0){return 1;}
    else if(x==0){return 0;}
    else{return -1;}
}
double f(double x){
    return x*x*x-x+5;
}
double muller(double x0,double x1,double x2){
    double p,h,a,b,d,e,sigma1,sigma2,h1=x1-x0,h2=x2-x1,count=1;;
    sigma1=(f(x1)-f(x0))/h1;sigma2=(f(x2)-f(x1))/h2;
    a=(sigma2-sigma1)/(h1+h2);
    while(count<1000){
        b=sigma2+h2*a;
        d=sqrt(b*b-4*f(x2)*a);
        if(sign(b-d)*(b-d)<sign(b+d)*(b+d)){e=b+d;}
        else{e=b-d;}
        h=-2*f(x2)/e;
        p=x2+h;
        if(h*sign(h)<Epsilon)break;
        x0=x1;
        x1=x2;
        x2=p;
        h1=x1-x0;
        sigma1=(f(x1)-f(x0))/h1;
        sigma2=(f(x2)-f(x1))/h2;
        a=(sigma2-sigma1)/(h2+h1);
        count++;
    }
    if(count>900){return 0;}
    else {return p;}
}
int main() {
    int k=1;
    double results[4];results[0]=0;
    cout<<"here";
    for(int i=-20;i<100;i++){
        cout<<i<<endl;
        if(sign(muller(i-1,i,i+1)-results[k])*
           (muller(i-0.1,i,i+0.1)-results[k-1])
           >10*Epsilon){cout<<"here"<<muller(i-0.1,i,i+0.1)<<endl;results[k]=muller(i-0.1,i,i+0.1);k=k+1;}
        if(k==4)break;
    }
    cout<<"here";
    if(results[2]==0){
    double three[4],one[2];
    one[1]=-muller(-2,-1.9,-1.8);
    one[0]=1;
    three[0]=1;three[2]=-1;three[3]=5;
    double result[3];
    result[1]=three[1]-one[1];
    result[0]=1;
    result[2]=three[3]/one[2];
    if(result[1]*result[1]-4*result[0]*result[2]<0){cout<<-result[1]/2/result[0]
        <<"+-"<<sqrt(result[1]*result[1]-4*result[0]*result[2])/2/result[0]<<"i"<<"\t"<<results[1];}}
    else if(results[3]==0){cout<<results[1]<<results[2];}
    else{cout<<results[1]<<results[2]<<results[3];}
    return 0;
}

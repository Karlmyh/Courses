#include<iostream>
#include<math.h>
#include <iomanip>
#define PI 3.14159265
using namespace std;
double Abs(double x){
    if(x>=0){return x;}
    else{return -x;}}
int sgn(float x){
    if(x>0){return 1;}
    else if(x==0){return 0;}
    else{return -1;}
}
double f(float x){
    return x-sin(x);
}

int main(){
    float a=1,b=2,temp=1.5,epsilon=0.001;
    while(a-b>epsilon||a-b<-epsilon){
        temp=(a+b)/2;
        if(sgn(sin(temp)/temp-0.5)!=sgn(sin(b)/b-0.5)){a=temp;}
        else{b=temp;}
    }
    cout<<b;
    float x;
    cin>>x;
    if(x<=a&&x>=-a){
        double sum=0,add=-x*x*x/6;
        int count=2;
        int i=0;
        while(Abs(add)>pow(10,-20)){add=-add*x*x/(2*count*(2*count+1));i++;count++;}
        //while(add!=0){add=-add*x*x/(2*count*(2*count+1));i++;count++;}
        double adds[i];
        add=x*x*x/6;
        for(int j=0;j<i;j++){adds[j]=add;
            //cout<<setprecision(45)<<add<<endl;
            add=-add*x*x/(2*count*(2*count+1));}
        for(int j=i-1;j>=0;j--){sum=sum+adds[j];}
        cout<<setprecision(44)<<sum<<endl<<f(x)<<endl;

    }
    else{cout<<f(x);}
    return 0;
}

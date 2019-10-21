#include <iostream>
#include <math.h>
#include <iomanip>
using namespace std;
int main() {
    int N=30;
    double a[N],b[N];
    a[0]=1;a[1]=1.0/3;
    b[0]=1;b[1]=4;
    for(int i=2;i<N;i++){
        a[i]=(13*a[i-1]-4*a[i-2])/3;
        b[i]=(13*b[i-1]-4*b[i-2])/3;
    }
    for(int i=0;i<N;i++){cout<<setprecision(25)<<"x"<<i<<" "<<a[i]<<"\t"<<b[i]<<endl;}
    for(int i=0;i<N;i++){cout<<setprecision(25)<<"x"<<i<<" "<<a[i]-pow(3,-i)<<"\t"<<b[i]-pow(4,i)<<endl;}
    return 0;
}

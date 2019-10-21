#include <iostream>
#define E 2.71828
using namespace std;
int main() {
    double temp,I=E-1,N=50,epsilon=0.0001;
    for(int i=0;i<N;i++){
        cout<<"y"<<i<<" "<<I<<endl;
        I=E-(i+1)*I;
    }
    return 0;
}

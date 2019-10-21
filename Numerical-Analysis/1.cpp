#include <iostream>
#include <math.h>
#include <string.h>
using namespace std;
void printbinary2(double b){
    double a=b;
    unsigned int *p=(unsigned int *)&a;
    int len=sizeof(double);
    int i,k;;
    for(i=8*len-1;i>=0;i--)
    {
        k=(*p)>>i&1;
        cout<<k;
    }
    cout<<'\n';
    
}
void printbinary1(float b){
    float a=b;
    unsigned int *p=(unsigned int *)&a;
    int len=sizeof(float);
    int i,k;;
    for(i=8*len-1;i>=0;i--)
    {
        k=(*p)>>i&1;
        cout<<k;
    }
    cout<<'\n';
    
}
int main() {
    float i=0,supof=1,infof=1,mepre=2,temp=0,me=0;
    while(supof!=2*supof){
        temp=supof;
        supof=supof*2;
        i++;
    }
    supof=temp;
    while((temp/2+supof)*2!=temp/2+supof){
        supof=temp/2+supof;
        temp=temp/2;
    }
    while(infof/2>0){
        infof=infof/2;
        i++;
    }
    while((mepre+1)/2!=1){
        mepre=(mepre+1)/2;
    }
    me=(mepre-1)/2;
    cout<<"float"<<"OFL"<<supof<<endl;
    printf("%x\n", *(int *)&supof);
    cout<<"float"<<"UFL"<<infof<<endl;
    printf("%x\n", *(int *)&infof);
    //char a[16]=(char *)&infof;
    //char *a=(char *)&infof;
    //for(int i=0;i<16;i++){cout<<a[i];}
    cout<<"float"<<"MP"<<me<<endl;
    printf("%x\n", *(int *)&me);
    //ofstream outfile("out1.bin",ios::out|ios::binary);
    //outfile.write((char*)&b,sizeof(float));
    //
    double i2=0,supof2=1,infof2=1,mepre2=2,me2=0,temp2=0;
    while(supof2!=2*supof2){
        temp2=supof2;
        supof2=supof2*2;
        i2++;
    }
    supof2=temp2;
    while((temp2/2+supof2)*2!=temp2/2+supof2){
        supof2=temp2/2+supof2;
        temp2=temp2/2;
    }
    while(infof2/2>0){
        infof2=infof2/2;
        i2++;
    }
    while((mepre2+1)/2!=1){
        mepre2=(mepre2+1)/2;
    }
    me2=(mepre2-1)/2;
    cout<<"double"<<"OFL"<<supof2<<endl;
    双上溢值: cout<<std::numeric_limits<double>::max()<<endl;
    printbinary2(supof2);
    cout<<"double"<<"UFL"<<infof2<<endl;
    双规约下溢值: cout<<std::numeric_limits<double>::denorm_min()<<endl;
    printbinary2(infof2);
    cout<<"double"<<"MP"<<me2<<endl;
    双机器精度: cout<<std::numeric_limits<double>::epsilon()<<endl;
    printbinary2(me2);
    return 0;
}

#include <iostream>
#include <math.h>
#include <iomanip>
using namespace std;
int main() {
    for(int m=3;m<40;m++){
    int n=m+1;
    double a[m][n];
    for(int i=0;i<m;i++){
        for(int j=0;j<m;j++){
            a[i][j]=1.0/(j+i+1);
        }
    }
        for(int i=0;i<m;i++){
            a[i][m]=0;
            for(int j=0;j<m;j++){
                a[i][m]+=a[i][j];
            }
        }
    clock_t start=clock();
    double temp2[n];
    double temp1[n];
    ///////////////////////方法二储存每行最大值
    double s[m];
    for(int i=0;i<m;i++){
        s[i]=a[i][0];
        for(int j=0;j<m;j++){
            if(a[i][j]>s[i]){
                s[i]=a[i][j];
            }
            
        }
    }
    
    for(int i=0;i<m;i++){
        ///////////////////////方法一找到最大位置
        /*
        int k=i;
        double max=abs(a[i][i]);
        for(int j=i;j<m;j++){
            if(fabs(a[j][i])>max){
                max=fabs(a[j][i]);
                k=j;
            }
        }
         */
        ///////////////////////方法二找到最大位置
        
         int k=i;
         double max=abs(a[i][i]/s[i]);
         for(int j=i;j<m;j++){
         if(fabs(a[j][i]/s[j])>max){
         max=fabs(a[j][i]/s[j]);
         k=j;
         }
         }
        
        ///////////////////////交换d

        for(int t=i;t<n;t++){
            temp2[t]=a[k][t];
        }
        for(int t=i;t<n;t++){
            a[k][t]=a[i][t];
        }
        for(int t=i;t<n;t++){
            a[i][t]=temp2[t];
        }
        ///////////////////////算系数
        for(int j=i+1;j<m;j++){
            temp1[j]=a[j][i]/temp2[i];
        }
        ///////////////////////相减
        for(int j=i+1;j<m;j++){
            for(int k=i;k<n;k++){
                a[j][k]-=temp1[j]*temp2[k];
            }
        }
    }
    ///////////////////////输出
        /*
    for(int q=0;q<m;q++){
        for(int w=0;w<n;w++){
            cout<<setprecision(2)<<a[q][w]<<"\t";
        }
        cout<<endl;
    }
         */
    double results[m];
    for(int i=0;i<m;i++){
        results[i]=a[i][n-1];
    }
    results[m-1]=results[m-1]/a[m-1][m-1];
    for(int i=m-2;i>=0;i--){
        for(int j=m-1;j>i;j--){
            results[i]-=a[i][j]*results[j];
        }
        results[i]=results[i]/a[i][i];
    }
    clock_t end=clock();
        double resultsum=results[0]*results[0];
    for(int i=0;i<m;i++){
        
            resultsum+=results[i]*results[i];
        
        //cout<<results[i]<<" ";
    }
        cout<<sqrt(resultsum)<<"\t"<<"\t"<<sqrt(m)<<"\t"<<"\t"<<abs(sqrt(resultsum)-sqrt(m))<<endl;
    //cout<<endl<<"time"<<(end-start)<<endl;
    }
    return 0;
}

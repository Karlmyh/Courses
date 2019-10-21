#include <iostream>
#include <math.h>
#include <iomanip>
using namespace std;
int main() {
    int m=3,n=m+1;
    double a[m][n];
    for(int i=0;i<m;i++){
        for(int j=0;j<n;j++){
            cin>>a[i][j];
        }
    }
    clock_t start=clock();
    double temp1[n];
    int index[m];
    for(int i=0;i<m;i++){
        index[i]=i;
    }
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
            if(fabs(a[index[j]][i]/s[index[j]])>max){
                max=fabs(a[index[j]][i]/s[index[j]]);
                k=j;
            }
        }
        
        ///////////////////////交换行顺序数组的值
        
        int temp=index[k];
        index[k]=index[i];
        index[i]=temp;
        ///////////////////////算系数
        for(int j=i+1;j<m;j++){
            temp1[index[j]]=a[index[j]][i]/a[index[i]][i];
        }
        ///////////////////////相减
        for(int j=i+1;j<m;j++){
            for(int s=i;s<n;s++){
                a[index[j]][s]-=temp1[index[j]]*a[index[i]][s];
            }
        }
    }
    ///////////////////////输出
    for(int q=0;q<m;q++){
        for(int w=0;w<n;w++){
            cout<<setprecision(2)<<a[q][w]<<"\t";
        }
        cout<<endl;
    }
    double results[m];
    for(int i=0;i<m;i++){
        results[i]=a[i][n-1];
    }
    results[index[m-1]]=results[index[m-1]]/a[index[m-1]][m-1];
    for(int i=m-2;i>=0;i--){
        for(int j=m-1;j>i;j--){
            results[index[i]]-=a[index[i]][j]*results[index[j]];
        }
        results[index[i]]=results[index[i]]/a[index[i]][i];
    }
    clock_t end=clock();
    for(int i=0;i<m;i++){
        cout<<results[index[i]]<<" ";
    }
        cout<<endl<<"time"<<(end-start)<<endl;
    return 0;
}

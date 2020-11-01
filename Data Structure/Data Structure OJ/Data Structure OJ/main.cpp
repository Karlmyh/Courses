#include<cstdio>
#include<iostream>
using namespace std;
char w[110000];
int m,n,j,u,c,s;
int main()
{
    m=n=j=u=c=s=0;
    int ans=0;
    while (cin>>w[m])
    {
        //cin>>w[m];
        //tmp = w[m];
        //if (m>=1&&w[m-1]==0){    m++;
           // cout<<"ha";
            //break;}
        m++;
    }
    cout<<m;
    for (int i=0;i<m;i++)
    {
        if (w[i]=='n') n++;
        if (w[i]=='j') j++;
        if (w[i]=='u') u++;
        if (w[i]=='c') c++;
        if (w[i]=='s') s++;
        cout<<n<<j<<u<<c<<s<<endl;
        if (n%2==0&&j%2==0&&u%2==0&&c%2==0&&s%2==0)
        {
            ans=i+1;
        }
    }
    printf("%d",ans);
    

}

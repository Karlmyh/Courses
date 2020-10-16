#include<cstdio>
char w[110000];
int m,n,j,u,c,s;
int main()
{
    m=n=j=u=c=s=0;
    int ans=0;
    while (scanf("%c",&w[m]))
    {
    
        if (w[m]==0){    m++; break;}
        m++;
    }
    for (int i=m-1;i>=0;i--)
    {
        if (w[i]=='n') n++;
        if (w[i]=='j') j++;
        if (w[i]=='u') u++;
        if (w[i]=='c') c++;
        if (w[i]=='s') s++;
        if (n%2==0&&j%2==0&&u%2==0&&c%2==0&&s%2==0)
        {
            ans=m-i;
        }
    }
    printf("%d",ans);
    

}

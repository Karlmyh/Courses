#include <iostream>
#include <string.h>
#include <math.h>
using namespace std;
class Complex
{
public:
    double _modulus;
    Complex(double r,double i);
    Complex();
    Complex operator+(const Complex &c);
    Complex operator-(const Complex &c);
    Complex operator*(const Complex &c);
    Complex operator/(const Complex &c);
    friend Complex findroot(const Complex &c);
    bool operator==(const Complex &c);
    double mode(Complex z);
    void print(Complex &c);
private:
    double _real;
    double _image;
};

Complex::Complex(double r, double i)
{
    _real = r;
    _image = i;
    _modulus=sqrt(r*r+i*i);
}

Complex::Complex(){
    _real = 0.0;
    _image = 0.0;
    _modulus=0.0;
}

//两复数相加
Complex Complex::operator+(const Complex& c){
    Complex temp(*this);
    temp._real = _real + c._real;
    temp._image = _image + c._image;
    temp._modulus=sqrt(temp._real*temp._real+temp._image*temp._image);
    return temp;
}
//(a+bi)-(c+di)=(a-c)+(b-d)i
Complex Complex::operator-(const Complex& c){
    Complex temp(*this);
    temp._real = _real - c._real;
    temp._image = _image - c._image;
    /*if(temp._image)*/
        temp._modulus=sqrt(temp._real*temp._real+temp._image*temp._image);
    return temp;
}
//(a+bi)(c+di)=(ac-bd)+(bc+ad)i
Complex Complex::operator*(const Complex& c){
    Complex temp(*this);
    temp._real = (_real * c._real) - (_image * c._image);
    temp._image = (_image * c._real) + (_real * c._image);
        temp._modulus=sqrt(temp._real*temp._real+temp._image*temp._image);
    return temp;
}
//(a+bi)/(c+di)=(ac+bd)/(c^2+d^2) +(bc-ad)/(c^2+d^2)i
Complex Complex::operator/(const Complex& c){
    Complex temp(*this);
    temp._real = ((_real * c._real) + (_image * c._image))/((c._real * c._real) + (c._image * c._image));
    temp._image = ((_image * c._real) - (_real * c._image)) / ((c._real * c._real) + (c._image * c._image));
        temp._modulus=sqrt(temp._real*temp._real+temp._image*temp._image);
    return temp;
}

bool Complex::operator==(const Complex &c)
{
    return(_real == c._real) && (_image == c._image);
}
Complex findroot(const Complex& c){
    Complex temp=c;
    temp._real=sqrt(c._modulus)*sin(atan(-c._image/c._real)/2);
    temp._image=sqrt(c._modulus)*cos(atan(c._image/c._real)/2);
    temp._modulus=sqrt(temp._real*temp._real+temp._image*temp._image);
    return temp;
}
void Complex::print(Complex &c)
{
    cout << c._real << "+ " << c._image << "i" << endl;
}
double mode(Complex z){
    double t;
    t= z._modulus;
    return t;
}
#define Epsilon 0.000000001
int sign(double x){
    if(x>0){return 1;}
    else if(x==0){return 0;}
    else{return -1;}
}
double f(double x){
    return x*x*x-x+5;
}
Complex g(Complex x){
    Complex z=x*x*x;
    z=z-x;
    z=z+Complex(5,0);
    return z;
}

Complex newton(Complex x){
    Complex x2,x1;
    x1=Complex(0,0);x2=x;
    while(mode(x1-x2)>Epsilon){
        x1=x2;
        x2=x1-g(x1)/(Complex(3,0)*x1*x1-Complex(1,0));
    }
    return x1;
}
double muller(double x0,double x1,double x2){
    double p,h,a,b,d,e,sigma1,sigma2,h1=x1-x0,h2=x2-x1,count=0;
    sigma1=(f(x1)-f(x0))/h1;sigma2=(f(x2)-f(x1))/h2;
    a=(sigma2-sigma1)/(h1+h2);
    while(1){
        b=sigma2+h2*a;
        if(sign(b*b-4*f(x2)*a)<0){return 0;}
        else{
        d=sqrt(b*b-4*f(x2)*a);
        if(sign(b-d)*(b-d)<sign(b+d)*(b+d)){e=b+d;}
        else{e=b-d;}
            cout<<e<<endl;
        h=-2*f(x2)/e;
            cout<<h<<"h";
        p=x2+h;
        if(h*sign(h)<Epsilon){break;}
        count++;if(count>100){return 0;}
        x0=x1;
        x1=x2;
        x2=p;
        h1=x1-x0;
        sigma1=(f(x1)-f(x0))/h1;
        sigma2=(f(x2)-f(x1))/h2;
        a=(sigma2-sigma1)/(h2+h1);
        }}
    cout<<p<<"here is p"<<endl;
    return p;
}
double mulleroriginal(double x0,double x1,double x2){
    double p,h,a,b,d,e,sigma1,sigma2,h1=x1-x0,h2=x2-x1,count=0;
    sigma1=(f(x1)-f(x0))/h1;sigma2=(f(x2)-f(x1))/h2;
    a=(sigma2-sigma1)/(h1+h2);
    while(1){
        b=sigma2+h2*a;
        d=sqrt(b*b-4*f(x2)*a);
        if(sign(b-d)*(b-d)<sign(b+d)*(b+d)){e=b+d;}
        else{e=b-d;}
        h=-2*f(x2)/e;
        p=x2+h;
        if(h*sign(h)>Epsilon)break;
        count++;if(count>100){return 0;}
        x0=x1;
        x1=x2;
        x2=p;
        h1=x1-x0;
        sigma1=(f(x1)-f(x0))/h1;
        sigma2=(f(x2)-f(x1))/h2;
        a=(sigma2-sigma1)/(h2+h1);
    }
    return p;
}
Complex mullercomplex(Complex x0,Complex x1,Complex x2){
    Complex p,h,a,b,d,e,sigma1,sigma2,h1=x1-x0,h2=x2-x1;
    int count=0;
    sigma1=(g(x1)-g(x0))/h1;sigma2=(g(x2)-g(x1))/h2;
    a=(sigma2-sigma1)/(h1+h2);
    while(1){
        b=sigma2+h2*a;
        d=findroot(b*b-Complex(4,0)*g(x2)*a);
        if(mode(b-d)<mode(b+d)){e=b+d;}
        else{e=b-d;}
        h=Complex(0,0)-Complex(2,0)*g(x2)/e;
        p=x2+h;
        if(mode(h)>Epsilon){break;}
        count++;if(count>5000){return Complex(0,0);}
        x0=x1;
        x1=x2;
        x2=p;
        h1=x1-x0;
        sigma1=(g(x1)-g(x0))/h1;
        sigma2=(g(x2)-g(x1))/h2;
        a=(sigma2-sigma1)/(h2+h1);
    }
    return p;
}
int main()
{
    /*
    double polynomial[4];
    polynomial[0]=1;polynomial[1]=0;polynomial[2]=-1;polynomial[3]=5;
    int k=1;
    double results[4];results[0]=0;
    for(int i=-20;i<100;i++){
        if(sign(muller(i-1,i,i+1)-results[k-1])*
           (muller(i-0.1,i,i+0.1)-results[k-1])
           >10*Epsilon&&muller(i-1,i,i+1)!=0){results[k]=muller(i-0.1,i,i+0.1);k=k+1;}
        if(k==4)break;
    }
    for(int i=0;i<4;i++){
        cout<<results[i]<<endl;
    }
                double after[3];
    for(int i=0;i<4;i++){
        if(results[i]!=0){
            cout<<results[i]<<endl;
            after[0]=polynomial[0];
            for(int j=1;j<3;j++){
                after[j]=polynomial[j]+after[j-1]*results[i];
            }
            break;
        }
    }
    Complex z1,z2;
    if(after[1]*after[1]-4*after[0]*after[2]<0){
        z1=Complex(-after[1]/after[0]/2,sqrt(-after[1]*after[1]+4*after[0]*after[2])/2/after[0]);
        z2=Complex(-after[1]/after[0]/2,-sqrt(-after[1]*after[1]+4*after[0]*after[2])/2/after[0]);
        z1=newton(z1);z2=newton(z2);
    }
    
    Complex *c=NULL;
    c->print(z1);
    c->print(z2);
     */
    /*
    int k=1;
    Complex results[4];results[0]=Complex(0,0);
    for(int i=-20;i<100;i++){
        for(int j=-20;j<100;j++)
        if(mode(mullercomplex(Complex(i,j), Complex(i+1,j), Complex(i,j+1))-results[k-1])
           >0.2&&mode(mullercomplex(Complex(i,j), Complex(i+1,j), Complex(i,j+1))-Complex(0,0))>Epsilon)
        {results[k]=mullercomplex(Complex(i,j), Complex(i+1,j), Complex(i,j+1));k=k+1;}
        if(k==4)break;
    }
     */
    Complex *c=NULL;

    Complex z1=mullercomplex(Complex(0.9,1.3), Complex(0.9,1.4), Complex(0.9,1.2));
    Complex z2=mullercomplex(Complex(0.9,-1.3), Complex(0.9,-1.4), Complex(0.9,-1.2));
    Complex z3=mullercomplex(Complex(-1.9,0), Complex(-2,0.11), Complex(-1.9,-0.1));
    c->print(z1);
    c->print(z2);
    c->print(z3);
    z1=newton(z1);
    z2=newton(z2);
    z3=newton(z3);
    c->print(z1);
    c->print(z2);
    c->print(z3);
}


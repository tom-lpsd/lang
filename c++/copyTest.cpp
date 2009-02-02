#include <iostream>
using namespace std;

class A {
public:
  A(){
    cout << "A's constructor" << endl;
  }
  A(const A &a){
    cout << "A's copy constructor" << endl;
  }
  A &operator = (const A &a){
    cout << "A's operator = " << endl;
    return *this;
  }
  virtual ~A(){
    cout << "A's destructor " << endl;
  }
};

class B : public A{
public:
  B(){
    cout << "B's constructor" << endl;
  }
  B(const B &a) : A(a){
    cout << "B's copy constructor" << endl;
  }
  B &operator = (const B &b){
    A::operator=(b);
    cout << "B's operator = " << endl;
    return *this;
  }
  virtual ~B(){
    cout << "B's destructor " << endl;
  }
};

B f()
{
  cout << "function f()" << endl;
  B a,buf; 
  return buf;
}

int main()
{
  B b,c;
  b = c;
  B d(f());
  cout << "hoge" << endl;
  return 0;
}

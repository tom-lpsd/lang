#include <functional>
#include <algorithm>
#include <iostream>
using namespace std;

class A {
  int a_;
public:
  A(int a=0) : a_(a) {}
  virtual void say(int x){
    a_+=x;
    cout << "Hello " << a_ << "\n";
  }
  virtual ~A() {}
};

class B : public A {
public:
  void say(int x){
    cout << "Bhello " << x << "\n";
  }
};

int main()
{
  A a[10];
  A *b[10];
  for(int i=0;i<10;i++){
    b[i] = new A(i);
  }
  delete b[3];
  b[3] = new B();
  for_each(a,a+10,bind2nd(mem_fun_ref(&A::say),9));
  for_each(b,b+10,bind2nd(mem_fun(&A::say),10));
  int c[10];
  for(int i=0;i<10;i++){
    c[i] = i*2;
  }
  for_each(c,c+10,bind1st(mem_fun(&A::say),b[0]));
  for(int i=0;i<10;i++){
    delete b[i];
  }
  return 0;
}

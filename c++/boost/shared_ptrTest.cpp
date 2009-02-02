#include <iostream>
#include <boost/shared_ptr.hpp>
using namespace std;
using namespace boost;

class A {
  int x_;
public:
  A() : x_(100) {
    cout << "A's constructor" << endl; 
  }
  ~A() { 
    cout << "A's destructor" << endl; 
  }
  void sayHello() {
    cout << "Hello World!" << endl;
  }
  int getValue() {
    return x_;
  }
};

class B : public A {
};

shared_ptr<A> f(void)
{
  return shared_ptr<A>(new B);
}

void g(shared_ptr<A> p)
{
  cout << "p's value is " << p->getValue() << "." << endl;
}

int main()
{
  shared_ptr<A> p = f();
  shared_ptr<A> pp;

  g(p);
  pp = p;
  p->sayHello();
  return 0;
}

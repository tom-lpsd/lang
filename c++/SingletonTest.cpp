#include <iostream>
#include "loki/Singleton.h"
using namespace std;
using namespace Loki;

class A {
  A(){}
  A(const A&);
  A &operator=(const A&);
  friend class CreateUsingNew<A>;
};

int main()
{
  typedef SingletonHolder<A> SingleA;
  A &a = SingleA::Instance();
  A &b = SingleA::Instance();
  cout << &a << endl;
  cout << &b << endl;
  return 0;
}

#include <iostream>
using namespace std;

template<typename T1,typename T2>
class A {
public:
  void f(){
    cout << "f()" << endl;
  }
  void h(){
    cout << "h()" << endl;
  }
};

template<typename T>
void A<double,T>::f() {
  cout << "g() " << endl;
}

int main()
{
  A<double,int> a;
  a.f();
  a.h();
  return 0;
}

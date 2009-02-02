#include <iostream>
#include <vector>
#include "Conversion.hpp"
using namespace std;

class A {
};

class B : public A {
};

template<bool, typename T>
class C {
public:
  void print(){
    cout << "class C" << endl;
  }
};

template<typename T>
class C<true,T> {
public:
  void print(){
    cout << "class C special" << endl;
  }
};

int main()
{
  cout << Conversion<double,int>::exists << ' '
       << Conversion<char,char*>::exists << ' '
       << Conversion<size_t,vector<int> >::exists << endl;

  C<SUPERSUBCLASS(A,B), double> c;
  c.print();

  return 0;
}

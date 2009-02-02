#include <iostream>
#include "myutils.hpp"
#include "Conversion.hpp"
using namespace std;

class A {};
class B : public A {};

int main()
{
  Select<SUPERSUBCLASS(A,B),double,A>::Result a;
  a = 0.4;
  cout << a << endl;;
  return 0;
}

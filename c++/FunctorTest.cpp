#include "loki/Functor.h"
#include <iostream>
using namespace std;
using namespace Loki;

struct TestFunctor {
  void operator () (int i, double d){
    cout << "TestFunctor::operator() (" << i
	 << ", " << d << ") called.\n" ;
  }
};

int main()
{
  TestFunctor f;
  Functor<void, LOKI_TYPELIST_2(int, double)> cmd(f);
  cmd(5,5.4);
  return 0;
}

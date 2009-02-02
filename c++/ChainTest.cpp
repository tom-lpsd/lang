#include <iostream>
#include "loki/Functor.h"
using namespace std;
using namespace Loki;

void f()
{
  cout << "f()" << endl;
}

void g()
{
  cout << "g()" << endl;
}

void h(int i)
{
  cout << "h(" << i << ")" << endl;
}

int main()
{
  Functor<> cmd1(f);
  Functor<> cmd2(g);
  Functor<> cmd3(Chain(cmd1,cmd2));
  Functor<void, LOKI_TYPELIST_1(int)> cmd4(h);
  Functor<> cmd5(BindFirst(cmd4,100));
  Functor<> cmd6(Chain(cmd3,cmd5));

  cmd6();

  return 0;
}

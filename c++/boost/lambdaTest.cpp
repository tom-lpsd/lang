#include <iostream>
#include <algorithm>
#include <list>
#include <boost/lambda/bind.hpp>
#include <boost/lambda/lambda.hpp>
using namespace std;
using namespace boost::lambda;

int foo(int x)
{
  static int y = 0;
  return x*++y;
}

int main()
{
  int v[] = {1,2,3,4,5};
  int num = sizeof(v)/sizeof(int);
  for_each(v, v+num, _1 = 1);
  for_each(v, v+num, _1 = bind(foo, _1));
  for_each(v, v+num, cout << _1 << "\n");
}

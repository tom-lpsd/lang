#define _GLIBCXX_DEBUG
#include <iostream>
#include <valarray>
using namespace std;

int main()
{
  valarray<double> a(10);
  a[10] = 10.8;
  cout << a[10] << endl;
  return 0;
}

#include <iostream>
#include <cmath>
using namespace std;

template<typename T, typename U>
T *create(const U &arg)
{
  cout << "OK" << endl;
  return new T(arg);
}

int main()
{
  double *x;
  x = create<double>(4);
  cout << *x << endl;
  delete x;
  cout << sizeof(create<double>(40)) << endl;
  return 0;
}

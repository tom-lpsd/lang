#include <iostream>
using namespace std;

template<int N>
class Factorial {
public:
  static const int value = N * Factorial<N-1>::value;
};

template<>
class Factorial<1> {
public:
  static const int value = 1;
};

int main()
{
  cout << Factorial<10>::value << endl;
  return 0;
}

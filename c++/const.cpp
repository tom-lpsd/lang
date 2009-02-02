#include <iostream>
using namespace std;

int main()
{
  int a = 3;

  const int *x = &a;  // ポインタの指す先がconst
  //int * const x = &a; // ポインタ自体がconst

  x = 0;
  cout << *x << endl;

  return 0;
}

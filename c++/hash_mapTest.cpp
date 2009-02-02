#include <ext/hash_map>
#include <iostream>
using __gnu_cxx::hash_map;
using namespace std;

int main()
{
  hash_map<int,int> a;
  a[1] = 255;
  a[980] = 222;
  cout << a[1] << " " << a.size() << endl;
  return 0;
}

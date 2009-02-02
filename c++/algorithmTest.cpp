#include <valarray>
#include <iostream>
#include <algorithm>
#include <functional>
using namespace std;

template<typename T>
class Print {
public:
  void operator () (const T &v) {
    cout << v << "\n";
  }
};

class plus_eq {
public:
  void operator () (int &v){
    v += 30;
  }
};

// mem_fun_refを使うためのクラス
class A {
  int a;
public:
  A(int b = 1) : a(b) {}
  void print(int b){
    cout << a+b << "\n";
  }
};

int main()
{
  const int num = 10;
  valarray<int> a(2,num);
  valarray<int> b(29,num);
  A c[num];

//   for_each(&a[0],&a[num],plus_eq());

  for_each(c,&c[num],bind2nd(mem_fun_ref(&A::print),40)); // mem_fun_refのテスト
  transform(&a[0],&a[num],&a[0],&a[0],multiplies<int>());
  for_each(&a[0],&a[num],Print<int>());

  cout << endl << bind1st(plus<int>(),3)(4) << endl;

  double d[] = {0.0,1.0,2.0,10.3};
  double e[] = {2.2,1.8,3.3,4.0};

  swap_ranges(d,d+sizeof(d)/sizeof(double),e);

  copy(d,d+sizeof(d)/sizeof(double),ostream_iterator<double>(cout," "));
  cout << endl;
  copy(e,e+sizeof(e)/sizeof(double),ostream_iterator<double>(cout," "));
  cout << endl;
  return 0;
}

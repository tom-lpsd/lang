#include <iostream>
using namespace std;

template<typename T>
class A {
  T a_;
public:
  A(T a) : a_(a) {}
  void print() { cout << a_ << endl; }
};

template<>
class A<double> {
  double a_;
public:
  A(double a) : a_(a) {}
  void print() { cout << "hoge" << endl; }
};

template<typename T1, template<typename> class T2>
class B {
  T2<T1> b_;
public:
  B(T1 b) : b_(T2<T1>(b)) {}
  void print() { b_.print(); }
};

int main()
{
  B<double,A> a(400);
  a.print();
  return 0;
}

#include <iostream>
using namespace std;

class A{
  int x_;
public:
  A(int x) : x_(x) {}
  A(const A &a) : x_(a.x_) {}
  A &operator= (const A &a){
    x_ = a.x_;
    return *this;
  }
  void print(){
    cout << x_ << endl;
  }
};

int main()
{
  A a(100);
  a.print();

  A b = a;
  b.print();

  return 0;
}

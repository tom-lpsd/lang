#include <iostream>
using namespace std;

class A {
public:
  void sayHello(){
    cout << "Hello World!" << endl;
  }
  virtual void setValue(int x) = 0;
  virtual ~A() {}
};

A *f()
{
  static int a = 0;

  class B : public A {
  public:
    void setValue(int x){
      a = x;
    }
  };

  cout << a << endl;

  static B b;
  return &b;
}

int main()
{
  f()->setValue(10);
  f()->setValue(100);
  f()->sayHello();
  return 0;
}

#include <iostream>
using namespace std;

class A {
private:

  class B {
  public:
    void hello() {
      cout << "Hello World!!" << endl;
    }
  };

  int x;
  int y;
  B b;

public:

  A() : x(10), y(20) {}

  void hello() {
    b.hello();
  }

};

void f(){

  class A {
  public:
    void hello(){
      cout << "Hello World from inner class!" << endl;
    }
    void job(){
      static int x = 100;
      class B {
      public:
	void hello(){
	  cout << "Hello World from inner inner class!" <<  x << endl;
	}
      };
      B b;
      b.hello();
    }
  };

  A a;
  a.hello();
  a.job();
}

int main()
{
  A a;
  a.hello();
  f();
  return 0;
}

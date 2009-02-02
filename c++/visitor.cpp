#include <iostream>
using namespace std;

class BaseVisitor;

class A {
public:
  virtual void Accept(BaseVisitor &) = 0;
};

class B;
class C;

class BaseVisitor {
public:
  virtual void visitB(B &b) = 0;
  virtual void visitC(C &b) = 0;
};

class B : public A {
public:
  void Accept(BaseVisitor &v) {
    v.visitB(*this);
  }
};

class C : public A {
public:
  void Accept(BaseVisitor &v) {
    v.visitC(*this);
  }
};

class Visitor : public BaseVisitor {
public:
  void visitB(B &b) {
    cout << "visit B" << endl;
  }
  void visitC(C &c) {
    cout << "visit C" << endl;
  }
};

class Visitor2 : public BaseVisitor {
public:
  void visitB(B &b) {
    cout << "visit B 2" << endl;
  }
  void visitC(C &c) {
    cout << "visit C 2" << endl;
  }
};

int main()
{
  Visitor vis;
  Visitor2 vis2;
  B b;
  b.Accept(vis);
  b.Accept(vis2);
  return 0;
}

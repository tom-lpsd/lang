#include <iostream>
using namespace std;

class A {
public:
    virtual void Aoriginal() {
	cout << "Aorig" << endl;
    }
    virtual void foo() {
	cout << "A" << endl;
    }
    virtual ~A() {}
};

class B {
public:
    virtual void Boriginal() {
	cout << "Borig" << endl;
    }
    virtual void foo() {
	cout << "B" << endl;
    }
    virtual ~B() {}
};

class C : public A, public B {
public:
    virtual void foo() {
	cout << "C" << endl;
    }
};

int main() 
{
    C *c = new C;
    A *a = c;
    B *b = c;
    cout << a << endl;
    cout << b << endl;
    cout << c << endl;
    a->foo();
    b->foo();
    c->foo();
    a->Aoriginal();
    b->Boriginal();
    delete c;
    return 0;
}

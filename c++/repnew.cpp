#include <cstdlib>
#include <iostream>
using namespace std;

class Foo;

void foo(Foo *, int);

class Foo {
public:
    int x, y;
    Foo() : x(10), y(20) { 
	cout << "Foo is constructed." << endl; 
    }
    virtual ~Foo() {
	cout << "Foo is destructed." << endl;
    }
    virtual void foo(int x) {
	cout << x << endl;
	cout << y << endl;
	cout << "foo" << endl;
    }
    virtual void bar() {
	typedef void (*f)(void);
	((f)(::foo))();
	cout << "bar" << endl;
    }
};

void foo(Foo *f, int x) { 
    f = *(&f + 4);
    cout << f->x << " " << f->y << " " << *(&x+4) << endl; 
    cout << "::foo" << endl; 
}

int main()
{
    int x[] = {0, 0, 0};
    new (x) Foo;
    cout << x[1] << " "
	 << x[2] << endl;
    typedef void (*f)(Foo*, int);
    int *h = (int*)x[0] + 2;
    ((f)(*h))((Foo*)x, 123);

    h = (int*)x[0] + 3;
    ((f)(*h))((Foo*)x, 456);

    ((Foo*)x)->~Foo();
    return 0;
}

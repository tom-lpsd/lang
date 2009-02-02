#include <iostream>
#include <boost/timer.hpp>
using namespace std;
using namespace boost;

class Foo {
public:
    void foo() {
	int x = 0;
	for(int i=0;i<50000;++i) {
	    x += i;
	}
    }
};

class Bar {
public:
    virtual void foo() = 0;
    virtual ~Bar() {};
};

class Baz : public Bar {
public:
    void foo() {
	int x = 0;
	for(int i=0;i<50000;++i) {
	    x += i;
	}
    }
};

int main()
{
    Foo *f = new Foo;
    timer t;
    for (int i=0;i<100000;++i) {
	f->foo();
    }
    cerr << t.elapsed() << endl;
    delete f;

    Bar *b = new Baz;
    timer t2;
    for (int i=0;i<100000;++i) {
	b->foo();
    }
    cerr << t2.elapsed() << endl;
    delete b;

    return 0;
}


#include <iostream>
using namespace std;

void hello(int)
{
    cout << "int" << endl;
}

void hello(long)
{
    cout << "long" << endl;
}

void hello(double)
{
    cout << "double" << endl;
}

void hello(char*)
{
    cout << "char*" << endl;
}

template<typename T>
struct Foo1 {
    template<typename TT>
    struct iFoo {
	void hello() {
	    T x; TT y;
	    ::hello(x);
	    ::hello(y);
	}
    };
};

template<typename T>
struct Foo2 {
    template<typename TT>
    struct iFoo {
	void hello() {
	    T x; TT y;
	    ::hello(y);
	    ::hello(x);
	}
    };
};

template<typename T>
struct Bar {
    template<typename TT>
    void hello(TT) {
	typename T::template iFoo<TT> x;
	x.hello();
    }
    void world() {
	cout << "world" << endl;
    }
};

int main()
{
    Bar<Foo1<int> > bar1;
    Bar<Foo2<double> > bar2;
    bar1.hello(0L);
    bar2.hello((char*)"hello");
    Bar<int> bar3;
    bar3.world();
    return 0;
}


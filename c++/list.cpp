#include <iostream>
using namespace std;

#define list3(a, b, c) Cons<a, Cons<b, Cons<c, Nil> > > 

template<int N, typename T>
struct Cons {
    const static int n = N;
    typedef T Tail;
};

class Nil {};

template<typename T>
struct Display {
    static void display() {
	cout << T::n << " ";
	Display<typename T::Tail>::display();
    }
};

template<int N> 
struct Display<Cons<N, Nil> > {
    static void display() {
	cout << N << endl;
    }
};

int main()
{
    typedef Cons<20, Cons<32, Cons<40, Nil> > > MyList;
    Display<MyList>::display();
    Display<list3(10, 11, 12)>::display();
    return 0;
}


#include <iostream>
#include "Typelist.hpp"
using namespace std;

template<class T> struct Print;

template<> struct Print<int>{
  static void print () {
    cout << "int" << endl;
  }
};

template<> struct Print<double>{
  static void print () {
    cout << "double" << endl;
  }
};

template<> struct Print<long>{
  static void print () {
    cout << "long" << endl;
  }
};

template<> struct Print<float>{
  static void print () {
    cout << "float" << endl;
  }
};

int main()
{
  typedef TYPELIST_2(double,int) A;
  typedef Append<A,float>::Result B; 
  typedef Append<B,long>::Result C; 

  Print<TypeAt<C,0>::Result>::print();
  Print<TypeAt<C,1>::Result>::print();
  Print<TypeAt<C,2>::Result>::print();
  Print<TypeAt<C,3>::Result>::print();

  cout << IndexOf<C,int>::value << endl;

  typedef Append<C, double>::Result D;
  typedef EraseAll<D,double>::Result E;

  Print<TypeAt<E,0>::Result>::print();
  Print<TypeAt<E,1>::Result>::print();
  Print<TypeAt<E,2>::Result>::print();

  typedef TYPELIST_5(int, long, int, long, int) F;
  typedef NoDuplicates<F>::Result G;
  Print<TypeAt<G,0>::Result>::print();
  Print<TypeAt<G,1>::Result>::print();

  typedef Replace<G, long , double>::Result H;
  Print<TypeAt<H,0>::Result>::print();
  Print<TypeAt<H,1>::Result>::print();

  cout << endl;
  typedef ReplaceAll<F, int, float>::Result I;
  Print<TypeAt<I,0>::Result>::print();
  Print<TypeAt<I,1>::Result>::print();
  Print<TypeAt<I,2>::Result>::print();
  Print<TypeAt<I,3>::Result>::print();
  Print<TypeAt<I,4>::Result>::print();

  return 0;
}

#include <iostream>
#include "loki/HierarchyGenerators.h"
using namespace std;
using namespace Loki;

typedef LOKI_TYPELIST_3(int, int, int) A;
typedef Tuple<A> B;

template<int i,class T>
void printTuple(Tuple<T> t, ostream &os, NullType)
{
  os << "\b)";
}

template<int i, class T1, class T2, class T3>
void printTuple(Tuple<T1> t, ostream &os, Typelist<T2,T3>)
{
  os << Field<i>(t) << ",";
  printTuple<i+1>(t,os,T3());
}

template<class T>
ostream &operator << (ostream &os, Tuple<T> t)
{
  os << "(" << Field<0>(t) << ",";
  printTuple<1>(t,os,typename T::Tail());
  return os;
}

int main()
{
  B a;
  Field<0>(a) = 3;
  Field<1>(a) = 10;
  Field<2>(a) = 101;

  cout << a << endl;

  return 0;
}

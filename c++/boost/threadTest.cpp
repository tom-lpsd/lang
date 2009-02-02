#include <iostream>
#include <boost/thread.hpp>
using namespace std;
using namespace boost;

mutex m;

void h(char c)
{
  mutex::scoped_lock l(m);
  while(true){
    cout << c << "\n";
  }
}

void f()
{
  h('f');
}

void g()
{
  h('g');
}

int main()
{
  thread t1(f);
  thread t2(g);
  t1.yield();
  t2.yield();
  t1.join();
  t2.join();
  return 0;
}

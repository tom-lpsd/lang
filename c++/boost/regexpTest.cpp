#include <iostream>
#include <boost/regex.hpp>
using namespace std;
using namespace boost;

int main()
{
  char a[] = "abcdefg";

  regex reg("(abc)(.*)");
  cmatch what;

  cout << regex_match(a, what, reg) << endl;
  cout << what[0] << endl;
  cout << what[1] << endl;
  cout << what[2] << endl;

  return 0;
}

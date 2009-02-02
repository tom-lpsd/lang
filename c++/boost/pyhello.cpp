#include <string>
#include <boost/python.hpp>
using namespace std;

string add_hello(string s)
{
    return "Hello, " + s;
}

int square(int n)
{
    return n*n;
}

BOOST_PYTHON_MODULE(pyhello)
{
    using namespace boost::python;

    def("greet", add_hello);
    def("square", square);
}


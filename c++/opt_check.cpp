#include <vector>
#include <valarray>
#include <list>
#include "Timer.hpp"
using namespace std;
using namespace utility;

vector<double> foo()
{
    vector<double> v(100000);
    for (vector<double>::size_type i=0;i<v.size();++i) {
	v[i] = random();
    }
    return v;
}

void bar(vector<double> &v)
{
    v.resize(100000);
    for (vector<double>::size_type i=0;i<v.size();++i) {
	v[i] = random();
    }
}

vector<double> *baz()
{
    vector<double> *v = new vector<double>(100000);
    for (vector<double>::size_type i=0;i<v->size();++i) {
	(*v)[i] = random();
    }
    return v;
}

int main()
{
    {
	Timer t("return");
	for (int i=0;i<10000;++i) {
	    vector<double> v(foo());
	}
    }

    {
	Timer t("arguments");
	for (int i=0;i<10000;++i) {
	    vector<double> v;
	    bar(v);
	}
    }

    {
	Timer t("pointer");
	for (int i=0;i<10000;++i) {
	    vector<double> *v = baz();
	    delete v;
	}
    }
    return 0;
}

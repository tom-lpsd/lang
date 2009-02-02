#include <ctime>
#include <algorithm>
#include <iterator>
#include <boost/generator_iterator.hpp>
#include <boost/random.hpp>
#include <boost/numeric/ublas/io.hpp>
#include <boost/numeric/ublas/matrix.hpp>
#include <boost/numeric/ublas/matrix_proxy.hpp>
using namespace std;
using namespace boost;
using namespace boost::numeric::ublas;

void foo(input_iterator_tag) 
{
    cout << "input" << endl;
}

void foo(random_access_iterator_tag) 
{
    cout << "random" << endl;
}

int main()
{
    const int rows = 3;
    const int cols = 4;
    matrix<double> m(rows, cols);

    mt19937 rng;
    uniform_real<> ran(-10.0, 10.0);

    variate_generator<mt19937, uniform_real<> > r(rng, ran);

    generate(m.data().begin(), m.data().end(), r);

    for (matrix<double>::iterator1 i=m.begin1();i!=m.end1();i++) {
	for (matrix<double>::iterator2 j=i.begin();j!=i.end();j++) {
	    cout << *j << " " << j.index1() << " " << j.index2() << endl;
	}
    }
    cout << m << endl;
//    iterator_traits<matrix<double>::iterator1>::iterator_category h;
    random_access_iterator_base<dense_random_access_iterator_tag, matrix<double>::iterator1 , double>::iterator_category h;
    foo(h);

    cout << distance(m.begin2(), m.end2()) << endl;

    return 0;
}

#include <iostream>
#define BOOST_UBLAS_SHALLOW_ARRAY_ADAPTOR
#include <boost/numeric/ublas/matrix.hpp>
#include <boost/numeric/ublas/storage.hpp>
using namespace std;
using namespace boost::numeric::ublas;

int main()
{
    double a[] = {1.3, 2.0, 3.0, 4.0};
    shallow_array_adaptor<double> ad(sizeof(a)/sizeof(double), a);
    cout << &ad[0] << " " << a << endl;
    matrix<double, row_major, shallow_array_adaptor<double> > m(2, 2, ad);

    cout << &m(0,0) << " " << &ad[0] << endl;
    return 0;
}

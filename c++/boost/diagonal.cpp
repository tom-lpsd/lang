#include <iostream>
#include <boost/numeric/ublas/io.hpp>
#include <boost/numeric/ublas/banded.hpp>
using namespace std;
using namespace boost::numeric::ublas;

int main()
{
    double data[] = {1.0, 2.0, 3.0};
    array_adaptor<double> ad(3, data);

    diagonal_matrix<double, row_major, array_adaptor<double> > d(3, ad);
    matrix<double> a(3,3);

    a(0,0) =  2.0; a(0,1) =  3.0; a(0,2) =  4.0;
    a(1,0) = -1.0; a(1,1) =  3.0; a(1,2) = -2.0;
    a(2,0) =  0.0; a(2,1) = -2.0; a(2,2) =  3.0;

    cout << prod(a,d) << endl;
    return 0;
}

#include <iostream>
#include <boost/numeric/ublas/io.hpp>
#include <boost/numeric/ublas/storage.hpp>
#include <boost/numeric/ublas/vector.hpp>
#include <boost/numeric/ublas/matrix.hpp>
#include <boost/numeric/ublas/matrix_proxy.hpp>
using namespace std;
using namespace boost::numeric::ublas;

int main()
{
    using boost::numeric::ublas::vector;
    double data[] = {1.0, 1.0, 1.0, 2.0, 2.0, 2.0};
    array_adaptor<double> data2(sizeof(data)/sizeof(double), data);

    typedef matrix<double, basic_row_major<>, array_adaptor<double> > matrix;

    matrix m(2,3, data2);

    cout << m << endl;

    matrix_row<matrix> m2 = row(m,1);
    vector<double> v2(2);
    v2(0) = 10.0; v2(1) = 20.0;

    vector<double> v3(prod(v2, m));
    cout << v3 << endl;
    return 0;
}

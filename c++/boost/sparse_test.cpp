#include <iostream>
#include <iterator>
#include <boost/numeric/ublas/io.hpp>
#include <boost/numeric/ublas/matrix_proxy.hpp>
#include <boost/numeric/ublas/matrix_sparse.hpp>
using namespace std;
using namespace boost::numeric::ublas;

int main()
{
    mapped_matrix<double> m(6, 6, 2);
    m(1,1) = 1.2;
    m(1,5) = 3.0;

    matrix_row<mapped_matrix<double> > row(m, 1);
    row(3) = 2.8;

    for (matrix_row<mapped_matrix<double> >::iterator it = row.begin();it!=row.end();it++) {
	cout << *it << " " << it.index() << endl;
    }
    cout << distance(row.begin(), row.end()) << endl;
    return 0;
}

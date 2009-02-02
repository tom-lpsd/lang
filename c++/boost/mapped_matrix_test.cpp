#include <boost/numeric/ublas/vector.hpp>
#include <boost/numeric/ublas/matrix_sparse.hpp>
#include <boost/numeric/ublas/matrix_proxy.hpp>
#include <boost/numeric/ublas/io.hpp>
using namespace std;
using namespace boost::numeric::ublas;

template<class T>
typename iterator_traits<typename matrix_row<T>::iterator>::difference_type
foo(matrix_row<T> &r)
{
    return distance(r.begin(), r.end());
}

int main() 
{
    mapped_matrix<double> m(10, 10);
    m(0, 3) = 1.0; m(0, 7) = 2.0; m(0, 9) = 3.0;
    m(9, 3) = 4.0;
    matrix_row<mapped_matrix<double> > r(m, 0);
    cout << distance(r.begin(), r.end()) << endl;
    cout << foo(r) << endl;
    for (matrix_row<mapped_matrix<double> >::iterator it = r.begin();it!=r.end();it++) {
	cout << *it << " " << it.index() << endl;
    }
    matrix_column<mapped_matrix<double> > c(m, 3);
    cout << distance(c.begin(), c.end()) << endl;
    for (matrix_column<mapped_matrix<double> >::iterator it = c.begin();it!=c.end();it++) {
	cout << *it << " " << it.index() << endl;
    }

    boost::numeric::ublas::vector<double> v(10);
    for (int i=0;i<10;++i) {
	v(i) = i * 10;
    }
    cout << m << endl;
    cout << v << endl;
    cout << prod(m, v) << endl;
    return 0;
}

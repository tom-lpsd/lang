#include <boost/numeric/ublas/io.hpp>
#include <boost/numeric/ublas/vector.hpp>
#include <boost/numeric/ublas/matrix.hpp>
#include <boost/numeric/ublas/matrix_proxy.hpp>
using namespace boost::numeric::ublas;

int main()
{
    vector<double> v1(3), v2(3);
    matrix<double> m1(3,3), m2(3,3);
    for (vector<double>::size_type i=0;i<3;++i) {
	v1(i) = i + 1;
	v2(i) = i * 2;
    }
    for (matrix<double>::size_type i=1;i<=3;++i) {
	for (matrix<double>::size_type j=1;j<=3;++j) {
	    m1(i-1,j-1) = i * j;
	    m2(i-1,j-1) = i * i + j;
	}
    }
    std::cout << v1 << std::endl;
    std::cout << v2 << std::endl;
    std::cout << m1 << std::endl;
    std::cout << m2 << std::endl;
    std::cout << inner_prod(v1, v2) << std::endl;
    std::cout << prod(v1, m1) << std::endl;

    matrix_row<matrix<double> > r(m1, 0);
    std::cout << prod(r, m2) << std::endl;
    return 0;
}

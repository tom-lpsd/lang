#include <iostream>
#include <boost/numeric/ublas/vector.hpp>
#include <boost/numeric/ublas/vector_proxy.hpp>
#include <boost/numeric/ublas/matrix.hpp>
#include <boost/numeric/ublas/triangular.hpp>
#include <boost/numeric/ublas/lu.hpp>
#include <boost/numeric/ublas/io.hpp>
using namespace boost::numeric::ublas;  // boost::numeric::ublas 名前空間を使用

template<typename T>
void InvertMatrix (const matrix<T>& input, matrix<T>& inverse) {
  typedef permutation_matrix<size_t> pmatrix;
  // create a working copy of the input
  matrix<T> A(input);
  // create a permutation matrix for the LU-factorization
  pmatrix pm(A.size1());

  // perform LU-factorization
  lu_factorize(A,pm);

  // create identity matrix of "inverse"
  inverse.assign(identity_matrix<T>(A.size1()));

  // backsubstitute to get the inverse
  lu_substitute(A, pm, inverse);
 }

int main()
{
  matrix<double> a( 2, 2 );
  matrix<double> b( 2, 2 );

  a(0,0) = 1.0;
  a(0,1) = 2.0;
  a(1,0) = 3.0;
  a(1,1) = 12.0;

  InvertMatrix(a,b);

//   for( int i=0; i!=3; ++i )
//     for( int j=0; j!=3; ++j )
//       b( i, j ) = (i+1)*(j+1);

  std::cout << a << std::endl;
  std::cout << b << std::endl;

  return 0;  
}

#include <iostream>
#include <boost/numeric/ublas/vector.hpp>
#include <boost/numeric/ublas/matrix.hpp>
#include <boost/numeric/ublas/io.hpp>

int main()
{
  using namespace boost::numeric::ublas;

  // ベクトル (1, 2, 3)
  vector<int> v( 3 );
  for( int i=0; i!=3; ++i )
    v( i ) = i+1;

  // 行列 (1 2 3)
  // 　　 (2 4 6)
  // 　　 (3 6 9)
  matrix<int> a( 3, 3 );
  for( int i=0; i!=3; ++i )
    for( int j=0; j!=3; ++j )
      a( i, j ) = (i+1)*(j+1);

  // a*vを表示
  std::cout << prod(a,v) << std::endl;

  return 0;
}

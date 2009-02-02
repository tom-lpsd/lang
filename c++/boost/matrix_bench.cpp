#define NDEBUG
#include <algorithm>
#include <boost/timer.hpp>
#include <boost/random.hpp>
#include <boost/numeric/ublas/matrix.hpp>
using namespace std;
using namespace boost;
using namespace boost::numeric::ublas;

int main()
{
    matrix<double> A(100, 60000), B(1000, 100);
    
    variate_generator<mt19937, uniform_real<> > 
	r1(mt19937(time(0)), uniform_real<>(0.0, 100.0)),
	r2(mt19937(time(0)+1), uniform_real<>(0.0, 100.0));

    std::generate(A.data().begin(), A.data().end(), r1);
    std::generate(B.data().begin(), B.data().end(), r2);

    matrix<double> C;

    timer t;
    C = prod(B, A);
    cerr << t.elapsed() << endl;

    return 0;
}

 

#include <iostream>
#include <fstream>
#include <cstdlib>
#include <itpp/base/mat.h>
#include <itpp/signal/fastica.h>
using namespace std;
using namespace itpp;

int main() 
{
    const static int dim = 3;
    const static int num = 65536;

    srandom(time(0));

    mat A(dim, dim);
    mat m1(dim,num), m2(num,dim);
    
    for (int i=0;i<dim;++i) {
	for (int j=0;j<dim;++j) {
	    A(i,j) = random()/double(RAND_MAX)-0.5;
	}
    }

    for (int i=0;i<dim;++i) {
	for (int j=0;j<num;++j) {
	    m1(i,j) = random()/double(RAND_MAX);
	}
    }

    m2 = A * m1;

    Fast_ICA fastica(m2);

    fastica.set_nrof_independent_components(m2.rows());
    fastica.set_non_linearity(  FICA_NONLIN_TANH );
    fastica.set_approach( FICA_APPROACH_DEFL );
    fastica.separate();

    mat ICs = fastica.get_independent_components();

    ofstream xs("fooo");
    ofstream ss("baaa");

    for (int i=0;i<num;++i) {
	for (int j=0;j<dim;++j) {
	    xs << ICs(j,i) << " ";
	    ss << m2(j,i) << " ";
	}
	xs << endl;
	ss << endl;
    }
    
    return 0;
}

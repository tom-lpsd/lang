#include <iostream>
#include <itpp/base/mat.h>
using namespace std;
using namespace itpp;

int main() 
{
    mat m(3,3);
    vec v(3);
    m(0,0) = 1.0; m(0,1) = 2.0; m(0,2) = 3.0;
    m(1,0) = 4.0; m(1,1) = 5.0; m(1,2) = 6.0;
    m(2,0) = 7.0; m(2,1) = 8.0; m(2,2) = 9.0;
    v(0) = 1.0; v(1) = 2.0; v(2) = 3.0;

    m.set_row(0, m.get_row(0) * v(0));
    m.set_row(1, m.get_row(1) * v(1));
    m.set_row(2, m.get_row(2) * v(2));

    cout << m << endl;

    return 0;
}

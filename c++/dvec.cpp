/*****************************************************************************
 * Example program using dvec.h (Vector implemented with expression templates)
 * Author: Todd Veldhuizen        (tveldhui@seurat.uwaterloo.ca)
 *
 * This program may be redistributed in an unmodified form.  It may not be
 * sold or used in a commercial product.
 *
 * For more information on these template techniques, please see the
 * Blitz++ Numerical Library Project, at URL http://monet.uwaterloo.ca/blitz/
 */

/****************************************************************************
 * Program listing: Example of optimized vector expressions.
 */

#include <iostream>
#include "dvec.h"
using namespace std;

int main()
{
    const int len = 10;

    DVec y(len), a(len), b(len), c(len), d(len);

    // Set up the vectors with some initial values
    int i;

    for (i=0; i < len; ++i)
    {
        a[i] = i;
        b[i] = i+1;
        c[i] = i+2;
        d[i] = i+1;
    }

    // Evaluate a vector expression
    y = (a+b)/(c-d);

    for (i=0; i < len; ++i)
        cout << y[i] << endl;

    return 1;
}

/*
 * Program output:
 * 1
 * 3
 * 5
 * 7
 * ..etc
 */

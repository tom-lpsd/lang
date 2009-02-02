#include <stdio.h>
#include <stdlib.h>

typedef unsigned int u_int;

double frexp(double value, int *eptr)
{
    union {
	double v;

	struct {
	    u_int u_mant2 : 32;
	    u_int u_mant1 : 20;
	    u_int u_exp   : 11;
	    u_int u_sign  :  1;
	} s;
    } u;

    if (value) {
	u.v = value;
	*eptr = u.s.u_exp - 1023;
	u.s.u_exp = 1023;
	return (u.v);
    }
    else {
	*eptr = 0;
	return ((double)0);
    }
}

int main(int argc, char *argv[])
{
    int exp;
    double v = 0.01;

    if (argc == 2) {
	v = atof(argv[1]);
    }

    printf("%lf\n", v);
    v = frexp(v, &exp);
    printf("%.100lf * 2^(%d)\n", v, exp);

    return 0;
}


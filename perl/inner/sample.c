#include <stdio.h>
#include "EXTERN.h"
#include "perl.h"

static PerlInterpreter *my_perl;

int main(int argc, char *argv[])
{
    SV *s, *r;
    my_perl = perl_alloc();
    perl_construct(my_perl);
    s = newSViv(39);
    r = newRV(s);
    printf("%d\n", s->sv_refcnt);
    SvREFCNT_dec(s);
    SvREFCNT_dec(r);
    perl_destruct(my_perl);
    perl_free(my_perl);
    return 0;
}


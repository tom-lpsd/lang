#include <EXTERN.h>
#include <perl.h>

static PerlInterpreter *my_perl;

SV *foo(void)
{
    SV *sv, *rv;
    sv = newSViv(320);
    printf("%d\n", SvIV(sv));
    rv = newRV(sv);
    SvREFCNT_dec(sv);
    return sv;
}

int main(int argc, char *argv[], char *env[])
{
    SV *sv;
    my_perl = perl_alloc();
    perl_construct(my_perl);
    perl_parse(my_perl, NULL, argc, argv, env);
    perl_run(my_perl);
    sv = foo();
    SvREFCNT_dec(sv);
    printf("%d\n", sizeof(SV));
    printf("%d\n", sizeof(XPVIV));
    perl_destruct(my_perl);
    perl_free(my_perl);
    return 0;
}


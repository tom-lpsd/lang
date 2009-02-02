#include <EXTERN.h>
#include <perl.h>

EXTERN_C void xs_init (pTHX);

static PerlInterpreter *my_perl;
int main(int argc, char *argv[], char *env[])
{
    char *my_argv[] = {"struct", "*.h", NULL};
    my_perl = perl_alloc();
    perl_construct(my_perl);
    perl_parse(my_perl, xs_init, argc, argv, env);
    perl_call_argv("search_files", G_DISCARD, my_argv);
    perl_destruct(my_perl);
    perl_free(my_perl);
    return 0;
}


#include <EXTERN.h>
#include <perl.h>

PerlInterpreter *my_perl;

int main(int argc, char *argv[], char *env[])
{
    static char *dummy_argv[] = {"", "-e", "0"};
    int num;

    my_perl = perl_alloc();
    perl_construct(my_perl);
    perl_parse(my_perl, NULL, 3, dummy_argv, env);
    if (perl_eval_va(
		"sub main::nice_number {"
		    "my $num = shift;"
		    "1 while ($num =~ s/(.*\\d)(\\d\\d\\d)/$1,$2/g);"
		    "$num;"
		"}"
		"sub main::test_nice {"
		    "my $num = shift;"
		    "nice_number(1 x $num);"
		"}",
		NULL ) == -1) {
	fprintf(stderr, "Eval unsuccessful. Aborted\n");
	exit(1);
    }

    for (num=1;num<=7;++num) {
	char buf[20];
	*buf = '\0';
	perl_call_va("test_nice",
		"i", num,
		"OUT",
		"s", buf, NULL);
	printf("%d: %s\n", num, buf);
    }
    perl_destruct(my_perl);
    perl_free(my_perl);
    return 0;
}


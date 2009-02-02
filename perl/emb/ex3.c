#include <EXTERN.h>
#include <perl.h>

static PerlInterpreter *my_perl;

void create_envt_vars(char **environ)
{
    SV *sv = NULL;
    char **env = environ;
    char buf[1000];
    char *envt_var_name;
    char *envt_var_value;
    char var_name[100];
    while(*env) {
	strcpy(buf, *env);
	envt_var_name = buf;
	envt_var_value = buf;
	while (*envt_var_value != '=') envt_var_value++;
	*envt_var_value++ = '\0';

	strcpy(var_name, "main::");
	strcat(var_name, envt_var_name);
	sv = perl_get_sv(var_name, TRUE);
	sv_setpv(sv, envt_var_value);
	env++;
    }
}

int main(int argc, char *argv[], char *env[])
{
    my_perl = perl_alloc();
    perl_construct(my_perl);
    perl_parse(my_perl, NULL, argc, argv, env);
    create_envt_vars(env);
    perl_run(my_perl);
    perl_destruct(my_perl);
    perl_free(my_perl);
    return 0;
}


#include <stdio.h>
#include "fill.h"

char *foo = "string.\n";

void setString(char **p)
{
    *p = foo;
}

void fill(char *p, int n)
{
    int i;
    for (i=0;i<n;++i) {
        *p++ = 'A' + i;
    }
    *p = '\0';
}

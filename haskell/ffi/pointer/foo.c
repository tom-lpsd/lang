#include <stdio.h>
#include <stdlib.h>
#include "foo.h"

Foo *init(int x, int y)
{
    Foo *f = (Foo*)malloc(sizeof(Foo));
    printf("%d %d\n", x, y);
    f->x = x;
    f->y = y;
    return f;
}

void destroy(Foo *f)
{
    printf("free %p: %d, %d\n", f, f->x, f->y);
    free(f);
}

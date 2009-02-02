#include "global.h"

static struct entry keywords[] = {
    "div", DIV,
    "mod", MOD,
    0, 0
};

void init(void)
{
    struct entry *p;
    for (p = keywords; p->token ; p++) {
	insert(p->lexptr, p->token);
    }
}

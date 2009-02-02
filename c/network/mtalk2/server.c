#include <stdio.h>
#include <stdlib.h>
#include "mtalk2.h"
#include "sessionman.h"

int main(void)
{
    if (sessionman_init(PORT) == -1) {
	fprintf(stderr, "cannot setup server\n");
	exit(1);
    }

    sessionman_loop();
}


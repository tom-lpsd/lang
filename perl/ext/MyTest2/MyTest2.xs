#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "ppport.h"

#include <mylib/mylib.h>

#include "const-c.inc"

MODULE = MyTest2		PACKAGE = MyTest2		

INCLUDE: const-xs.inc

double
foo(a, b, c)
        int a
        long b
        const char* c
    OUTPUT:
        RETVAL

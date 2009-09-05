#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "ppport.h"


MODULE = CoreDump		PACKAGE = CoreDump		

void
core_dump(str)
        SV * str
    INIT:
        STRLEN len;
        U8 *s;
        U8 *e;
    CODE:
        s = (U8 *)SvPV(str, len);
        e = SvEND(str);

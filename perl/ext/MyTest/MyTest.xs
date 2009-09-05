#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include <sys/param.h>
#include <sys/mount.h>

#include "ppport.h"


MODULE = MyTest		PACKAGE = MyTest		

void
hello()
    CODE:
        printf("Hello, World\n");

int
is_even(input)
        int input
    CODE:
        RETVAL = (input % 2 == 0);
    OUTPUT:
        RETVAL

void
round(arg)
        double arg
    CODE:
        if (arg > 0.0) {
            arg = floor(arg + 0.5);
        }
        else if (arg < 0.0) {
            arg = ceil(arg - 0.5);
        }
        else {
            arg = 0.0;
        }
    OUTPUT:
        arg

void
statfs(path)
        char * path
    INIT:
        int i;
        struct statfs buf;

    PPCODE:
        i = statfs(path, &buf);
        if (i == 0) {
            XPUSHs(sv_2mortal(newSVnv(buf.f_bavail)));
            XPUSHs(sv_2mortal(newSVnv(buf.f_bfree)));
            XPUSHs(sv_2mortal(newSVnv(buf.f_blocks)));
            XPUSHs(sv_2mortal(newSVnv(buf.f_bsize)));
            XPUSHs(sv_2mortal(newSVnv(buf.f_ffree)));
            XPUSHs(sv_2mortal(newSVnv(buf.f_files)));
            XPUSHs(sv_2mortal(newSVnv(buf.f_type)));
        }
        else {
            XPUSHs(sv_2mortal(newSVnv(errno)));
        }

SV *
multi_statfs(paths)
        SV * paths
    INIT:
        AV * results;
        I32 numpaths = 0;
        int i, n;
        struct statfs buf;

        if ((!SvROK(paths))
            || (SvTYPE(SvRV(paths)) != SVt_PVAV)
            || ((numpaths = av_len((AV *)SvRV(paths))) < 0))
        {
            XSRETURN_UNDEF;
        }
        results = (AV *)sv_2mortal((SV *)newAV());
    CODE:
        for (n = 0; n <= numpaths; n++) {
            HV * rh;
            STRLEN l;
            char *fn = SvPV(*av_fetch((AV *)SvRV(paths), n, 0), l);

            i = statfs(fn, &buf);
            if (i != 0) {
                av_push(results, newSVnv(errno));
                continue;
            }

            rh = (HV *)sv_2mortal((SV *)newHV());

            hv_store(rh, "f_bavail", 8, newSVnv(buf.f_bavail), 0);
            hv_store(rh, "f_bfree",  7, newSVnv(buf.f_bfree),  0);
            hv_store(rh, "f_blocks", 8, newSVnv(buf.f_blocks), 0);
            hv_store(rh, "f_bsize",  7, newSVnv(buf.f_bsize),  0);
            hv_store(rh, "f_ffree",  7, newSVnv(buf.f_ffree),  0);
            hv_store(rh, "f_files",  7, newSVnv(buf.f_files),  0);
            hv_store(rh, "f_type",   6, newSVnv(buf.f_type),   0);

            av_push(results, newRV((SV *)rh));
        }
        RETVAL = newRV((SV *)results);
    OUTPUT:
        RETVAL

#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.

AC_PREREQ(2.61)
AC_INIT(procs, 0.0)
AM_INIT_AUTOMAKE
AC_CONFIG_SRCDIR([procs.c])
AC_CONFIG_HEADER([config.h])

# Checks for programs.
AC_PROG_CC

AC_CHECK_FILES([/proc])

# Checks for libraries.

# Checks for header files.
AC_HEADER_STDC
AC_CHECK_HEADERS([stdlib.h sys/param.h])
AC_CHECK_HEADERS([sys/sysctl.h],,,[#include <sys/param.h>])

# Checks for typedefs, structures, and compiler characteristics.
AC_C_CONST
AC_TYPE_SIZE_T
AC_CHECK_TYPES([struct kinfo_proc],,,[
#include <sys/param.h>
#include <sys/sysctl.h>
])

# Checks for library functions.
AC_FUNC_MALLOC

AC_CONFIG_FILES([Makefile])
AC_OUTPUT

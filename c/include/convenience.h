#ifndef _CONVENIENCE_H
#define _CONVENIENCE_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>
#include <stdarg.h>
#include <unistd.h>

#define MAXLINE 4096

static void err_doit(int errnoflag, const char *fmt, va_list ap)
{
  int errno_save;
  char buf[MAXLINE];
  
  errno_save = errno;
  vsprintf(buf,fmt,ap);
  if(errnoflag){
    sprintf(buf+strlen(buf), ": %s", strerror(errno_save));
  }
  strcat(buf, "\n");
  fflush(stdout);
  fputs(buf, stderr);
  fflush(NULL);
  return;
}

inline void err_ret(const char *fmt, ...)
{
  va_list ap;
  va_start(ap,fmt);
  err_doit(1,fmt,ap);
  va_end(ap);
  return;
}

inline void err_quit(const char *fmt, ...)
{
  va_list ap;
  va_start(ap,fmt);
  err_doit(0,fmt,ap);
  va_end(ap);
  exit(1);
}

inline void err_sys(const char *fmt, ...)
{
  va_list ap;
  va_start(ap,fmt);
  err_doit(1,fmt,ap);
  va_end(ap);
  exit(1);
}

inline void err_dump(const char *fmt, ...)
{
  va_list ap;
  va_start(ap, fmt);
  err_doit(1,fmt,ap);
  va_end(ap);
  abort();
  exit(1);
}

#endif /* _CONVENIENCE_H */

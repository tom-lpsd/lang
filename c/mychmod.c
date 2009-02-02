#include <sys/types.h>
#include <sys/stat.h>
#include "convenience.h"

int main(void)
{
  struct stat statbuf;

  if(stat("foo", &statbuf) < 0){
    err_sys("stat error for foo");
  }
  if(chmod("foo", (statbuf.st_mode & ~S_IXGRP) | S_ISGID) < 0){
    err_sys("chmod error for foo");
  }

  exit(0);
}

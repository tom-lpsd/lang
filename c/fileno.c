#include <stdio.h>
#include "convenience.h"

/**
 *  @file fileno.c
 *  @brief fileno関数を使ってみるだけのコードだったけど
 *         詳解UNIXプログラミングのプログラム5.3にした．
 */

void pr_stdio(const char *, FILE *);

int main(void)
{
  FILE *fp;

  fputs("enter any charcter\n", stdout);
  if(getchar() == EOF){
    err_sys("getchar error");
  }
  fputs("one line to standard error\n", stderr);

  pr_stdio("stdin",  stdin);
  pr_stdio("stdout", stdout);
  pr_stdio("stderr", stderr);

  if( (fp=fopen("/etc/hosts","r")) == NULL){
    err_sys("fopen error");
  }
  if(getc(fp) == EOF){
    err_sys("getc error");
  }
  pr_stdio("/etc/hosts",fp);
  exit(0);
}

void pr_stdio(const char *name, FILE *fp)
{
  printf("stream %s, ", name);
  if(fp->_flags & _IONBF){
    printf("unbufferd\n");
  }
  else if(fp->_flags & _IOLBF){
    printf("line buffered\n");
  }
  else{
    printf("fully buffered\n");
  }
}

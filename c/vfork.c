#include <sys/types.h>
#include <sys/unistd.h>
#include <sys/wait.h>
#include "convenience.h"

int main(void)
{
  pid_t pid;
  int hoge = 100;

  printf("Before fork hoge is %d",hoge);
  
  if( (pid=vfork()) < 0){
    err_sys("vfork error");
  }
  if(pid == 0){
    printf("Hello\n");
    hoge = 200;
    execlp("ls","-l","-al",NULL);
  }
  wait(NULL);
  printf("After fork hoge is %d",hoge);
  return 0;
}

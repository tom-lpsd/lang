#include <sys/stat.h>
#include "convenience.h"

int main(int argc, char *argv[])
{
  struct stat st;
  if(lstat(argv[1],&st) < 0){
    err_sys("stat failed");
  }

  printf("file size = %ld Byte\n", st.st_size);

  if(S_ISREG(st.st_mode)){
    printf("regular file!!\n");
  }
  else if(S_ISDIR(st.st_mode)){
    printf("directory!!\n");
  }

  printf("access time is %ld\n", st.st_atime);
  printf("modification time is %ld\n", st.st_mtime);
  printf("change time is %ld\n", st.st_ctime);

  exit(0);
}

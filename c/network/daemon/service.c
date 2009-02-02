#include <fcntl.h>
#include <string.h>
#include "bb.h"

#ifdef __APPLE__
#define DATA_DIR "/Users/tom/src/c/network/daemon/data"
#else
#define DATA_DIR "/home/tom/src/c/network/daemon/data"
#endif

#define MENUSTRING "1. call 2. absence 3. circle 4. event 9. quit \n"

static int process(int soc, int name);

void service(int soc, char *myname)
{
    pid_t mypid;
    char buf[BUF_LENGTH];
    int item;

    mypid=(int)getpid();
    sprintf(buf, "This is %s[%d] serving you.\n", myname, (int)mypid);
    write(soc, buf, strlen(buf));

    do {
	write(soc, MENUSTRING, strlen(MENUSTRING));
	read(soc, buf, 20);
	sscanf(buf, "%d", &item);
    } while (process(soc, item));

    close(soc);
}

static int process(int soc, int item)
{
    int fd;
    int cnt;
    char filename[FILENAME_LENGTH];
    char buf[BUF_LENGTH];

    if (item==9) {
	return 0;
    }

    sprintf(filename, "%s/data%d", DATA_DIR, item);

    if ((fd=open(filename, O_RDONLY))==-1) {
	write(soc, "invalid number.\n", 17);
	return 1;
    }

    while ((cnt=read(fd, buf, BUF_LENGTH))!=0) {
	write(soc, buf, cnt);
    }

    close(fd);
    return 1;
}



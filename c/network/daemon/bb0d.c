#include <stdio.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netdb.h>
#include <string.h>
#include <fcntl.h>

#include "bb.h"

extern void service(int soc, char *myname);

int main(int argc, char *argv[])
{
    struct sockaddr_in me;
    int soc_waiting;
    int soc;
    pid_t pid;

    memset((char*)&me, 0, sizeof(me));
    me.sin_family = AF_INET;
    me.sin_addr.s_addr = htonl(INADDR_ANY);
    me.sin_port = htons(PORT);

    if ((soc_waiting = socket(AF_INET, SOCK_STREAM, 0))<0) {
	perror("socket");
	exit(1);
    }

    if (bind(soc_waiting, (struct sockaddr*)&me, sizeof(me))==-1) {
	perror("bind");
	exit(1);
    }

    listen(soc_waiting, 5);
    fprintf(stderr, "successfully bound, now waiting.\n");

    while (1) {
	soc = accept(soc_waiting, NULL, NULL);

	if ((pid=fork())==(pid_t)0) {
	    close(soc_waiting);
	    service(soc, argv[0]);
	    exit(0);
	}
	else {
	    close(soc);
	    printf("My child [%d] now serving\n", (int)pid);
	}
    }
}



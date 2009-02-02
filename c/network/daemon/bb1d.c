#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netdb.h>
#include <string.h>
#include <syslog.h>
#include <signal.h>
#include <fcntl.h>

#include "bb.h"

extern void service(int, char *);
static void ending(int);

int main(int argc, char *argv[])
{
    struct sockaddr_in me;
    int soc_waiting;
    int soc;
    pid_t pid;

    if (fork()!=0) {
	exit(0);
    }

    setsid();

    if (fork()!=0) {
	exit(0);
    }

    chdir("/");

    close(0);
    close(1);
    close(2);

    signal(SIGTERM, ending);
    openlog(argv[0], LOG_PID, LOG_USER);

    memset((char*)&me, 0, sizeof(me));
    me.sin_family = AF_INET;
    me.sin_addr.s_addr = htonl(INADDR_ANY);
    me.sin_port = htons(PORT);

    if ((soc_waiting = socket(AF_INET, SOCK_STREAM, 0)) < 0) {
	syslog(LOG_ERR, "socket failed");
	exit(1);
    }

    if (bind(soc_waiting, (struct sockaddr*)&me, sizeof(me)) == -1) {
	syslog(LOG_ERR, "bind failed");
	exit(1);
    }

    listen(soc_waiting, 5);
    syslog(LOG_ERR, "listen succeeded");

    while (1) {
	soc = accept(soc_waiting, NULL, NULL);

	if ((pid=fork()) == (pid_t)0) {
	    close(soc_waiting);
	    service(soc, argv[0]);
	    exit(0);
	}
	else {
	    close(soc);
	}

	syslog(LOG_ERR, "My child [%d] now serving", (int)pid);
    }
}

static void ending(int d)
{
    syslog(LOG_ERR, "service terminated");
    closelog();
    exit(0);
}


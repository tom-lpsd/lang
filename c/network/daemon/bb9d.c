#include <sys/types.h>
#include <sys/socket.h>
#include <syslog.h>
#include "bb.h"

#define SOC 0

extern void service(int, char*);

int main(int argc, char *argv[])
{
    openlog(argv[0], LOG_PID, LOG_USER);
    syslog(LOG_ERR, "startup experiment");

    service(SOC, argv[0]);

    syslog(LOG_ERR, "shutdown experiment");
    closelog();

    shutdown(SOC, 2);
    exit(0);
}


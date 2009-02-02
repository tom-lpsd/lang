#include <stdio.h>
#include <string.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netdb.h>
#define HOSTNAME_LENGTH 64

int mserver_socket(in_port_t port, int backlog)
{
    struct addrinfo hints;
    struct addrinfo *res;
    int soc_waiting;
    char portstring[8];
    char hostname[HOSTNAME_LENGTH];

    gethostname(hostname, HOSTNAME_LENGTH);
    sprintf(portstring, "%d", port);
    memset((char*)&hints, 0, sizeof(struct addrinfo));
    hints.ai_family = AF_UNSPEC;
    hints.ai_socktype = SOCK_STREAM;

    if (getaddrinfo(hostname, portstring, &hints, &res) != 0) {
	perror("getaddrinfo");
	return -1;
    }

    if ((soc_waiting = socket(res->ai_family, res->ai_socktype, res->ai_protocol)) < 0) {
	perror("socket");
	return -1;
    }

    if (bind(soc_waiting, res->ai_addr, res->ai_addrlen) != 0) {
	perror("bind");
	return -1;
    }

    if (listen(soc_waiting, backlog) == -1) {
	perror("listen");
	return -1;
    }

    fprintf(stderr, "successfully setup, now waiting.\n");

    freeaddrinfo(res);

    return soc_waiting;
}

int mserver_maccept(int soc_waiting, int limit, void (*func)(int,int))
{
    int i;
    int fd;

    for (i=0;i<limit;++i) {
	if ((fd=accept(soc_waiting, NULL, NULL)) == -1) {
	    fprintf(stderr, "accept error\n");
	    return -1;
	}
	(*func)(i,fd);
    }

    close(soc_waiting);

    return fd;
}



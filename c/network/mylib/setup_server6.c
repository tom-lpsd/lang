#include "mylib.h"
#define HOSTNAME_LENGTH 64

int setup_sever(in_port_t port)
{
    struct addrinfo hints;
    struct addrinfo *res;
    int soc_waiting;
    int soc;
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

    if ((soc_waiting = socket(res->ai_family, res->ai_socktype, res->ai_protocol)) <0) {
	perror("socket");
	return -1;
    }

    if (bind(soc_waiting, res->ai_addr, res->ai_addrlen)!=0) {
	perror("bind");
	return -1;
    }

    listen(soc_waiting, 1);
    fprintf(stderr, "successfully bound, now waiting.\n");

    soc = accept(soc_waiting, NULL, NULL);

    close(soc_waiting);

    freeaddrinfo(res);

    return soc;
}



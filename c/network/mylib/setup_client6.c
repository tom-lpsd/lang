#include "mylib.h"

int setup_client(char *hostname, in_port_t port)
{
    struct addrinfo hints;
    struct addrinfo *res;
    int soc;
    char portstring[8];

    sprintf(portstring, "%d", port);
    memset((char*)&hints, 0, sizeof(struct addrinfo));
    hints.ai_family = AF_UNSPEC;
    hints.ai_socktype = SOCK_STREAM;

    if (getaddrinfo(hostname, portstring, &hints, &res) != 0) {
	perror("getaddrinfo");
	return -1;
    }

    if ((soc = socket(res->ai_family, res->ai_socktype, res->ai_protocol))<0) {
	perror("socket");
	return -1;
    }

    if (connect(soc, (struct sockaddr*)res->ai_addr, res->ai_addrlen) == -1) {
	perror("connect");
	return -1;
    }

    fprintf(stderr, "connected.\n");

    freeaddrinfo(res);

    return soc;
}


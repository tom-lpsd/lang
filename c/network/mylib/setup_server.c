#include "mylib.h"

int setup_server(in_port_t port)
{
    struct sockaddr_in me;
    int soc_waiting;
    int soc;

    memset((char*)&me, 0, sizeof(me));
    me.sin_family = AF_INET;
    me.sin_addr.s_addr = htonl(INADDR_ANY);
    me.sin_port = htons(port);

    if ((soc_waiting = socket(AF_INET, SOCK_STREAM, 0)) < 0) {
	perror("socket");
	return -1;
    }

    if (bind(soc_waiting, (struct sockaddr*)&me, sizeof(me)) == -1) {
	perror("bind");
	return -1;
    }

    listen(soc_waiting, 1);
    fprintf(stderr, "successfully bound, now waiting.\n");

    soc = accept(soc_waiting, NULL, NULL);

    close(soc_waiting);

    return soc;
}


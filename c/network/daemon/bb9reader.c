#include <stdio.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netdb.h>

#include "mylib.h"
#include "bb.h"

#define SERV_NAME "experiment"
#define SERV_PROTO "tcp"

extern void session(int);
static int setup(char *hostname);

int main(void)
{
    int soc = -1;
    char hostname[HOSTNAME_LENGTH];
    
    printf("Input Server's Host Name: ");
    fgets(hostname, HOSTNAME_LENGTH, stdin);
    chop_newline(hostname, HOSTNAME_LENGTH);

    if ((soc = setup(hostname)) < 0) {
	exit(1);
    }

    session(soc);
}

static int setup(char *hostname)
{
    int soc;
    struct servent *service_info;
    struct hostent *host_info;
    struct sockaddr_in server;

    if ((service_info = getservbyname(SERV_NAME, SERV_PROTO))==NULL) {
	perror("getservbyname");
	return -1;
    }

    if ((host_info = gethostbyname(hostname)) == NULL) {
	perror("gethostbyname");
	return -1;
    }

    memset((char*)&server, 0, sizeof(server));
    server.sin_family = AF_INET;
    server.sin_port = service_info->s_port;
    memcpy((char*)&server.sin_addr, host_info->h_addr, host_info->h_length);

    if ((soc = socket(AF_INET, SOCK_STREAM, 0)) < 0) {
	perror("socket");
	return -1;
    }

    if (connect(soc, (struct sockaddr*)&server, sizeof(server)) < 0) {
	perror("connect");
	return -1;
    }

    fprintf(stderr, "connected\n");

    return soc;
}


#include <stdio.h>
#include "race.h"
#include "mylib.h"
#include "sessionman.h"

int main(int argc, char *argv[])
{
    int num;
    int final;
    int soc_waiting;
    int maxfd;

    if (argc != 3) {
	fprintf(stderr, "Usage: s players stages\n");
	exit(1);
    }

    if ((num=atoi(argv[1])) <= 0 || num>MAX_PLAYERS) {
	fprintf(stderr, "players limit=%d\n", MAX_PLAYERS);
	exit(1);
    }

    if ((final=atoi(argv[2])) <= 0 || final>MAX_STAGES) {
	fprintf(stderr, "stage limit=%d\n", MAX_STAGES);
	exit(1);
    }

    if ((soc_waiting = mserver_socket(PORT, num))==-1) {
	fprintf(stderr, "cannot setup server\n");
	exit(1);
    }

    maxfd = mserver_maccept(soc_waiting, num, enter);

    sessionman_init(num, final, maxfd);

    sessionman_loop();

    return 0;
}

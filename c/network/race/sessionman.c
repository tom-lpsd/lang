#include <stdio.h>
#include <string.h>
#include <sys/select.h>
#include <sys/types.h>
#include "race.h"

#define MAX_DAMAGE 10

static int soc[MAX_PLAYERS];
static char name[MAX_PLAYERS][16];
static char p[MAX_PLAYERS * PLAYER_SIZE];

static fd_set mask;
static fd_set readOk;
static int width;

static int final;
static int num;
static int reached;
static int crashed;

static char g[MAX_PLAYERS * GRADE_SIZE];

static void recv_data(void);
static void send_data(void);
static void ending(void);

void enter(int i, int fd)
{
    int len;
    static char *login_mesg = "Your name?";
    char mesg[32];

    soc[i] = fd;
    write(soc[i], login_mesg, 11);
    read(soc[i], name[i], 16);

    sprintf(mesg, "%d\n", i);
    write(soc[i], mesg, strlen(mesg) + 1);
    printf("[%d] %s\n", i, name[i]);
}

void sessionman_init(int n, int fin, int maxfd)
{
    int i;
    static char mesg[10];

    num = n;
    final = fin;

    width = maxfd + 1;
    FD_ZERO(&mask);
    FD_SET(0, &mask);
    for (i=0;i<num;++i) {
	FD_SET(soc[i], &mask);
    }

    sprintf(mesg, "%d %d\n", num, final);
    for (i=0;i<num;++i) {
	write(soc[i], mesg, 10);
    }

    reached = 0;
    crashed = 0;
}

void sessionman_loop(void)
{
    while (reached + crashed < num) {
	recv_data();
	send_data();
    }
    ending();
}

static void recv_data(void)
{
    int i;

    readOk = mask;
    select(width, &readOk, NULL, NULL, NULL);

    for (i=0;i<num;++i) {
	if (FD_ISSET(soc[i], &readOk)) {
	    read(soc[i], &p[i * PLAYER_SIZE], PLAYER_SIZE);

	    if (p[i * PLAYER_SIZE + DAMAGE] >= MAX_DAMAGE) {
		g[(num-crashed-1) * GRADE_SIZE + ENTRYNUM] = i;
		strcpy(&g[(num-crashed-1) * GRADE_SIZE + ENTRYNAME], name[i]);
		crashed++;
	    }


	    if (p[i* PLAYER_SIZE + STAGE] > final) {
		g[reached * GRADE_SIZE + ENTRYNUM] = (char)i;
		strcpy(&g[reached * GRADE_SIZE + ENTRYNAME], name[i]);
		reached++;
	    }
	}
    }
}

static void send_data(void)
{
    int i;
    
    for (i=0;i<num;++i) {
	if (FD_ISSET(soc[i], &readOk)) {
	    write(soc[i], p, PLAYER_SIZE * num);
	}
    }
}

static void ending(void)
{
    int i;

    for (i=0;i<num;++i) {
	write(soc[i], g, GRADE_SIZE * num);
    }
}


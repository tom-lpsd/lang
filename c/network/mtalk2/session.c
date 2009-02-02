#include <string.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netdb.h>
#include <signal.h>
#include <curses.h>
#include "mtalk2.h"

#define MYNAME_LENGTH 12
#define SEND_WIN_WIDTH 60
#define SEND_WIN_HEIGHT 1
#define RECV_WIN_WIDTH 60
#define RECV_WIN_HEIGHT 13

static char send_buf[BUF_LEN];
static char *input_buf;
static char recv_buf[BUF_LEN];
static int soc;
static fd_set mask;
static int width;
static struct sockaddr_in server;
static struct sockaddr_in me;
static struct sockaddr_in from;
static socklen_t fromlen;
static char myname[MYNAME_LENGTH];
static int my_slot;

static WINDOW *win_send, *win_recv;
static WINDOW *frame_send, *frame_recv;

static void die(int);
static int login(void);
static void logout(void);

int session_setupclient(char *hostname, in_port_t port)
{
    struct hostent *server_ent;

    if ((server_ent = gethostbyname(hostname)) == NULL) {
	perror("gethostbyname");
	return -1;
    }

    memset((char*)&server, 0, sizeof(server));
    server.sin_family = AF_INET;
    server.sin_port = htons(port);
    memcpy((char*)&server.sin_addr, server_ent->h_addr, server_ent->h_length);

    if ((soc=socket(AF_INET, SOCK_DGRAM, 0)) < 0) {
	perror("socket");
	return -1;
    }

    memset((char*)&me, 0, sizeof(me));
    me.sin_family = AF_INET;
    me.sin_addr.s_addr = htonl(INADDR_ANY);
    me.sin_port = 0;

    if (bind(soc, (struct sockaddr*)&me, sizeof(me)) == -1) {
	perror("bind");
	return -1;
    }

    printf("successfully bound.\n");
    return login();
}

static int login(void)
{
    send_buf[0] = LOGIN;
    printf("Your name? ");
    fgets(myname, MYNAME_LENGTH, stdin);
    chop_newline(myname, MYNAME_LENGTH);

    strcpy(send_buf + 1, myname);
    sendto(soc, send_buf, strlen(send_buf)+1, 0, (struct sockaddr*)&server, sizeof(server));
    fromlen = sizeof(from);
    recvfrom(soc, recv_buf, BUF_LEN, 0, (struct sockaddr*)&from, &fromlen);

    if ((u_char)recv_buf[0] == CANNOT_LOGIN) {
	printf("cannot login\n");
	return -1;
    }
    else if ((u_char)recv_buf[0] == LOGIN_OK) {
	sscanf(recv_buf+1, "%02d", &my_slot);
	send_buf[0] = DATA;
	sprintf(send_buf+1, "%-10s-> ", myname);
	input_buf = send_buf + 1;
	printf("You have logged in.\n");
	return 1;
    }
    else {
	printf("recv_buf[0]==%u", (u_char)recv_buf[0]);
	return -2;
    }
}

void session_init(void)
{
    width = soc + 1;
    FD_ZERO(&mask);
    FD_SET(0, &mask);
    FD_SET(soc, &mask);

    initscr();
    signal(SIGINT, die);

    frame_send = newwin(SEND_WIN_HEIGHT+2, SEND_WIN_WIDTH+2, 18, 0);
    win_send = newwin(SEND_WIN_HEIGHT, SEND_WIN_WIDTH, 19, 1);
    box(frame_send, '|', '-');
    scrollok(win_send, TRUE);
    wmove(win_send, 0, 0);

    frame_recv = newwin(RECV_WIN_HEIGHT + 2, RECV_WIN_WIDTH + 2, 0, 0);
    win_recv = newwin(RECV_WIN_HEIGHT, RECV_WIN_WIDTH, 1, 1);
    box(frame_recv, '|', '-');
    scrollok(win_recv, TRUE);
    wmove(win_recv, 0, 0);

    cbreak();
    noecho();

    wrefresh(frame_recv);
    wrefresh(win_recv);
    wrefresh(frame_send);
    wrefresh(win_send);
}

void session_loop(void)
{
    int c, flag;
    fd_set readOk;
    int len;
    int i;
    int y, x;
    int n;

    flag = 1;
    len = 0;

    while (1) {
	readOk = mask;
	select(width, &readOk, NULL, NULL, NULL);

	if (FD_ISSET(0, &readOk)) {
	    c = getchar();

	    if (c=='\b' || c==0x10 || c==0x7F) {
		if (len==0) continue;
		--len;
		getyx(win_send, y, x);
		wmove(win_send, y, x-1);
		waddch(win_send, ' ');
		wmove(win_send, y, x-1);
	    }
	    else if (c=='\n' || c=='\r') {
		input_buf[len++] = '\n';
		sendto(soc, send_buf, len+14, 0, (struct sockaddr*)&server, sizeof(server));
		wclear(win_send);
		len=0;
	    }
	    else {
		input_buf[len++] = c;
		waddch(win_send, c);
	    }
	    wrefresh(win_send);
	}

	if (FD_ISSET(soc, &readOk)) {
	    fromlen = sizeof(from);
	    n = recvfrom(soc, recv_buf, BUF_LEN, 0, (struct sockaddr*)&from, &fromlen);

	    if ((u_char)recv_buf[0]==DATA) {
		for (i=1;i<n;++i) {
		    waddch(win_recv, recv_buf[i]);
		}
	    }
	    else if ((u_char)recv_buf[0]==END) {
		flag = 0;
	    }
	    wrefresh(win_recv);
	    wrefresh(win_send);
	}

	if (flag==0) break;
    }

    die(0);
}

static void die(int x)
{
    endwin();
    logout();
    close(soc);
    exit(0);
}

static void logout(void)
{
    send_buf[0] = LOGOUT;
    sprintf(send_buf+1, "%02d\n", my_slot);
    sendto(soc, send_buf, 4, 0, (struct sockaddr*)&server, sizeof(server));
}



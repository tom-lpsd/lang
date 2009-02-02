#include <stdlib.h>
#include <curses.h>
#include <signal.h>
#include <sys/select.h>
#include "session.h"

#define BUF_LEN 20
#define MIN_X 1
#define MIN_Y 1
#define MAX_X 60
#define MAX_Y 20

#define NORTH 'k'
#define SOUTH 'j'
#define EAST 'l'
#define WEST 'h'
#define QUIT 'q'

static int session_soc;
static fd_set mask;
static int width;
static char my_char, peer_char;

typedef struct {
    int x, y;
    char look;
} PLAYER;

static PLAYER me, peer;

static char buf[BUF_LEN];

static WINDOW *win;

static void hide(PLAYER *who);
static void show(PLAYER *who);
static int update(PLAYER *who, int c);
static int interpret(PLAYER *who);
static void die();

void session_init(int soc, char mc,
	int mx, int my, char pc, int px, int py)
{
    session_soc = soc;
    width = soc + 1;
    FD_ZERO(&mask);
    FD_SET(0, &mask);
    FD_SET(session_soc, &mask);
    me.look = mc;
    peer.look = pc;

    me.x = mx; me.y = my;
    peer.x = px; peer.y = py;

    initscr();
    signal(SIGINT, die);
    
    win = newwin(MAX_Y + 2, MAX_X + 2, 0, 0);
    box(win, '|', '-');

    cbreak();
    noecho();
}

void session_loop(void)
{
    int c;
    int flag;
    fd_set readOK;

    show(&me);

    flag = 1;

    while(1) {
	readOK = mask;
	select(width, &readOK, NULL, NULL, NULL);

	if (FD_ISSET(0, &readOK)) {
	    c = getchar();
	    hide(&me);
	    flag = update(&me, c);
	    show(&me);
	    write(session_soc, buf, BUF_LEN);
	    if (flag == 0) break;
	}

	if (FD_ISSET(session_soc, &readOK)) {
	    read(session_soc, buf, BUF_LEN);
	    hide(&peer);
	    flag = interpret(&peer);
	    show(&peer);
	    if (flag == 0) break;
	}
    }

    die();
}

static void show(PLAYER *who)
{
    wmove(win, who->y, who->x);
    waddch(win, who->look);
    wmove(win, who->y, who->x);
    wrefresh(win);
}

static void hide(PLAYER *who)
{
    wmove(win, who->y, who->x);
    waddch(win, ' ');
}

static int update(PLAYER *who, int c)
{
    switch(c) {
    case WEST:
	if (who->x > MIN_X)
	    who->x--;
	break;
    case SOUTH:
	if(who->y < MAX_Y)
	    who->y++;
	break;
    case NORTH:
	if(who->y > MIN_Y)
	    who->y--;
	break;
    case EAST:
	if(who->x < MAX_X)
	    who->x++;
	break;
    case QUIT:
	buf[0] = QUIT;
	return 0;
    default:
	break;
    }
    sprintf(buf, "%d %d\n", who->x, who->y);
    return 1;
}

static int interpret(PLAYER *who)
{
    if (buf[0] == 'q')
	return 0;

    sscanf(buf, "%d %d", &who->x, &who->y);
    return 1;
}

static void die(void)
{
    endwin();
    exit(0);
}


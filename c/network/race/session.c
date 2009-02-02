#include <curses.h>
#include <stdlib.h>
#include <signal.h>
#include <string.h>
#include "race.h"

static char p[MAX_PLAYERS * PLAYER_SIZE];
static char temp[PLAYER_SIZE];
static char g[MAX_PLAYERS * GRADE_SIZE];

static int num;
static int final;
static int soc;
static int entry_num;
static int flag;
static int final_state;

static char *me;

static WINDOW *win1, *win2;

static int get_my_location(void);
static void send_my_data(void);
static void del_all_locations(void);
static void show_all_locations(void);
static void recv_all_data(void);
static int new_stage(int);

static void init_data(void);
static int check(int, int);
static void ending(int);

static void die(void);

void session_init(int s)
{
    char buf[BUF_LENGTH];
    soc = s;

    read(soc, buf, BUF_LENGTH);
    printf("%s", buf);
    fgets(buf, BUF_LENGTH, stdin);
    chop_newline(buf, BUF_LENGTH);

    write(soc, buf, strlen(buf)+1);
    read(soc, buf, BUF_LENGTH);
    sscanf(buf, "%d", &entry_num);
    printf("Your entry number is %d\n", entry_num);
    read(soc, buf, BUF_LENGTH);
    sscanf(buf, "%d %d", &num, &final);
    printf("players are %d\n", num);
    printf("final stage is %d\n", final);

    signal(SIGINT, die);
    signal(SIGQUIT, die);
    signal(SIGTERM, die);
    signal(SIGSEGV, die);
    signal(SIGPIPE, die);

    initscr();
    noecho();
    crmode();
    nonl();

    win1 = newwin(22, 12, 1, 10);
    win2 = newwin(11, 25, 5, 40);
    box(win1, '|', '-');
    box(win2, '|', '-');

    new_stage(1);

    init_data();

    mvwprintw(win2, 2, 1, "Entry Num=%d", entry_num);
    mvwprintw(win2, 3, 2, "num  stage  damage");
    mvwprintw(win2, entry_num+4, 1, "*");

    show_all_locations();
}

void session_loop(void)
{
    flag = 1;

    while (flag) {
	flag = get_my_location();
	send_my_data();
	del_all_locations();
	recv_all_data();
	show_all_locations();
    }
    ending(final_state);
    die();
}

static int get_my_location(void)
{
    int c;

    c = getchar();

    switch (c) {
    case WEST:
	if (check(-1, 0)==1) {
	    temp[XPOS]--;
	}
	else {
	    temp[DAMAGE]++;
	}
	break;
    case SOUTH:
	if (check(0, 1)==1) {
	    temp[YPOS]++;
	}
	else {
	    temp[DAMAGE]++;
	}
	break;
    case NORTH:
	if (temp[YPOS]==(char)1) {
	    temp[STAGE]++;
	    temp[YPOS] = (char)21;
	    if (new_stage((int)temp[STAGE])==0) {
		final_state = 0;
		return 0;
	    }
	}
	else if (check(0, -1)==1) {
	    temp[YPOS]--;
	}
	else {
	    temp[DAMAGE]++;
	}
	break;
    case EAST:
	if (check(1, 0)==1) {
	    temp[XPOS]++;
	}
	else {
	    temp[DAMAGE]++;
	}
	break;
    default:
	break;
    }

    if (temp[DAMAGE]>=MAX_DAMAGE) {
	final_state = -1;
	return 0;
    }

    return 1;
}

static void send_my_data(void)
{
    write(soc, &temp, PLAYER_SIZE);
}

static void del_all_locations(void)
{
    int i;

    for (i=0;i<num;++i) {
	if (p[i * PLAYER_SIZE + STAGE] == me[STAGE]) {
	    mvwaddch(win1, p[i * PLAYER_SIZE + YPOS], 
		     p[i * PLAYER_SIZE + XPOS], ' ');
	}
    }
    touchwin(win1);
    wrefresh(win1);
}

static void recv_all_data(void)
{
    read(soc, p, PLAYER_SIZE * num);
}

static void show_all_locations(void)
{
    int i;

    for (i=0;i<num;++i) {
	if (p[i * PLAYER_SIZE + STAGE] == me[STAGE]) {
	    mvwaddch(win1, p[i * PLAYER_SIZE + YPOS],
		     p[i * PLAYER_SIZE + XPOS], (char)(i+0x30));
	}
    }
    touchwin(win1);
    wrefresh(win1);
    mvwprintw(win2, 9,2, "stage=%2d/%2d", (int)me[STAGE], final);
    for (i=0;i<num;++i) {
	mvwprintw(win2, i+4, 2, "stage=%2d %2d     %2d ",
		  i, (int)p[i * PLAYER_SIZE + STAGE],
		     (int)p[i * PLAYER_SIZE + DAMAGE]);
    }
    wrefresh(win2);
}

static int new_stage(int z)
{
    FILE *fp;
    int i;
    static char buf[16];

    if (z > final) return 0;

    sprintf(buf, "data/data%d", z);
    fp = fopen(buf, "r");
    for (i=1;i<=STAGE_LENGTH;++i) {
	fgets(buf, 16, fp);
	buf[10] = '\0';
	wmove(win1, i, 1);
	waddstr(win1, buf);
    }
    fclose(fp);
    return 1;
}

static void ending(int how)
{
    int i;

    wclear(win2);
    box(win2, '|', '-');

    if (how==0) {
	mvwprintw(win2, 1, 3, "Goal in, Wait!");
    }
    else {
	mvwprintw(win2, 1, 3, "Crashed, Wait!");
    }
    wrefresh(win2);

    read(soc, g, GRADE_SIZE * num);
    for (i=0;i<num;++i) {
	mvwprintw(win2, i+3, 1, "[%d] %d: %s", i+1,
		 (int)g[i * GRADE_SIZE + ENTRYNUM],
		 &g[i * GRADE_SIZE + ENTRYNAME]);
    }
    wrefresh(win2);
    getchar();
}

static void init_data(void)
{
    int i;

    me = p + PLAYER_SIZE * entry_num;
    for (i=0;i<num;++i) {
	p[i * PLAYER_SIZE + STAGE] = (char)1;
	p[i * PLAYER_SIZE + XPOS] = (char)(2+i);
	p[i * PLAYER_SIZE + YPOS] = (char)20;
	p[i * PLAYER_SIZE + DAMAGE] = (char)0;
    }
    memcpy(temp, me, PLAYER_SIZE);
}

static int check(int a, int b)
{
    int p, q;

    p = temp[XPOS] + a;
    q = temp[YPOS] + b;

    if (p<1 || p>STAGE_WIDTH || q<1 || q>STAGE_LENGTH+1) return 0;
    if ((A_CHARTEXT & mvwinch(win1, q, p))=='*') return 0;

    return 1;
}

static void die(void)
{
    endwin();
    echo();
    exit(1);
}


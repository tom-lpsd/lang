#include "mylib.h"

#define PORT (in_port_t)50001
#define HOSTNAME_LENGTH 64

extern void goban_init(int, char, char);
extern void goban_show(void);
extern int goban_peer_turn(void);
extern int goban_my_turn(void);


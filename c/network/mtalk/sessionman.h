#include <sys/types.h>
#include <netinet/in.h>

#define PORT (in_port_t)50002
#define MAX_ATTENDANTS 5

extern void enter(int, int);
extern void sessionman_init(int num, int maxfd);
extern void sessionman_loop(void);


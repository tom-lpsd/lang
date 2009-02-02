#include <netinet/in.h>

extern int session_setupclient(char *, in_port_t);
extern void session_init(void);
extern void session_loop(void);

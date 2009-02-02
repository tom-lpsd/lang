#include <sys/types.h>

#define LOGIN  (uint8_t)100
#define LOGOUT (uint8_t)101
#define DATA   (uint8_t)102
#define END    (uint8_t)199
#define LOGIN_OK (uint8_t)200
#define CANNOT_LOGIN (uint8_t)201
#define IN_USE (uint8_t)1
#define FREE   (uint8_t)0

#define HOSTNAME_LENGTH 64

#define PORT (in_port_t)50001
#define MAX_ATTENDANTS 5
#define BUF_LEN 256



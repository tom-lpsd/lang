#include <stdio.h>
#include <netdb.h>

void addr2str (char *addr, char buf[])
{
    sprintf(buf, "%u.%u.%u.%u", (unsigned char)addr[0], (unsigned char)addr[1], 
	    (unsigned char)addr[2], (unsigned char)addr[3]);
}


int main(void) 
{
    struct hostent *sv;
    char buf[256];

    if ((sv = (struct hostent *)gethostbyname("www.yahoo.co.jp")) == NULL) {
	perror("Error: gethostbyname");
	return -1;
    }

    addr2str(sv->h_addr, buf);
    printf("%s\n", buf);

    return 0;
}

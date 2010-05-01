#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/event.h>
#include <sys/time.h>

int main(void)
{
    int file = open("vnode.c", O_RDONLY);
    int queue = kqueue();
    struct kevent events[1];
    EV_SET(&events[0], file, EVFILT_VNODE, EV_ADD, NOTE_LINK, 0, NULL);
    int nevent = kevent(queue, events, 1, events, 1, NULL);
    for (int i=0;i<nevent;i++) {
        printf("link count changed\n");
    }
    close(queue);
    close(file);
    return 0;
}

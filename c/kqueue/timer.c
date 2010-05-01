#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/event.h>
#include <sys/time.h>

int main(void)
{
    int queue = kqueue();
    struct kevent events[1];
    struct kevent changes[1];
    EV_SET(&events[0], 1, EVFILT_TIMER, EV_ADD, NOTE_SECONDS, 1, NULL);
    int count = 1;
    while(1) {
        int nevent = kevent(queue, events, 1, changes, 1, NULL);
        for (int i=0;i<nevent;i++) {
            printf("%d sec\n", count);
        }
        if (count++ == 10) {
            break;
        }
    }
    close(queue);
    return 0;
}

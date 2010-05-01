#include <stdio.h>
#include <sys/time.h>
#include <event.h>

struct foo {
    char *msg;
    int counter;
    struct event *ev;
    struct timeval *timer;
};

void timer_handler(int fd, short event, void *arg)
{
    struct foo *f = arg;
    printf("%s\n", f->msg);
    if (f->counter++ == 100) {
        return;
    }
    else {
        evtimer_add(f->ev, f->timer);
    }
}

int main(void)
{
    struct timeval timer = { 0, 500000 };
    struct event ev;
    event_init();
    struct foo f = { "foo", 0, &ev, &timer };
    evtimer_set(&ev, timer_handler, &f);
    evtimer_add(&ev, &timer);
    event_dispatch();
    return 0;
}

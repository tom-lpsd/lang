#include <stdio.h>
#include <pthread.h>

static int com = 0;

pthread_mutex_t gm = PTHREAD_MUTEX_INITIALIZER;

void *foo(void *dummy)
{
    int i = 0;

    while (com < 100) {
	pthread_mutex_lock(&gm);
	for (i=0;i<100;++i) {
	    printf("foo ");
	}
	putchar('\n');
	printf("from foo %d\n", com++);
	pthread_mutex_unlock(&gm);
    }
}

void *bar(void *dummy)
{
    int i = 0;

    while (com < 100) {
	pthread_mutex_lock(&gm);
	for (i=0;i<100;++i) {
	    printf("bar ");
	}
	putchar('\n');
	printf("from bar %d\n", com++);
	pthread_mutex_unlock(&gm);
    }
}

int main(void)
{
    pthread_t th1, th2;
    pthread_create(&th1, NULL, foo, NULL);
    pthread_create(&th2, NULL, bar, NULL);
    pthread_join(th1, NULL);
    pthread_join(th2, NULL);
    return 0;
}

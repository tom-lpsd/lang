#include <stdio.h>
#include <pthread.h>

void cancel(void *any)
{
    printf("canceled!!\n");
}

void *foo(void *any)
{
    int i;
    pthread_cleanup_push(cancel, NULL);
    for (i=0;;++i) {
	pthread_testcancel();
	printf("a");
	if (i%30==0) {
	    printf("OK\n");
	}
    }
    pthread_cleanup_pop(0);
    return NULL;
}

int main(void)
{
    pthread_t th;
    pthread_create(&th, NULL, foo, NULL);
    sleep(2);
    pthread_cancel(th);
    pthread_join(th, NULL);
    return 0;
}

	

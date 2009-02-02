#include <pthread.h>
#include <stdio.h>

int main(void)
{
    pthread_attr_t atr;
    pthread_attr_init(&atr);
    pthread_attr_setscope(&atr, PTHREAD_SCOPE_SYSTEM);
    return 0;
}

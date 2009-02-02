#include <pthread.h>
#include <stdio.h>

pthread_mutex_t gmutex = PTHREAD_MUTEX_INITIALIZER;

void f(int *x)
{
  int i;
  pthread_mutex_lock(&gmutex);
  for(i=0;i<100;i++){
    printf("this is f %d\n",(*x)++);
  }
  pthread_mutex_unlock(&gmutex);
}

void g(int *x)
{
  int i;
  pthread_mutex_lock(&gmutex);
  for(i=0;i<100;i++){
    printf("this is g %d\n",(*x)++);
  }
  pthread_mutex_unlock(&gmutex);
}

int main(void)
{
  pthread_t p1,p2;
  int a = 0;
  pthread_create(&p1,NULL,(void*)f,(void*)&a);
  pthread_create(&p2,NULL,(void*)g,(void*)&a);
  pthread_join(p1,NULL);
  pthread_join(p2,NULL);
  return 0;
}

#include <stdio.h>

int sum_loop(int *data, int len, int x)
{
    if (len==0) {
	return x;
    }
    else {
	return sum_loop(++data, len-1, x + *data);
    }
}

int sum(int *data, int len)
{
    return sum_loop(data, len, *data);
}

int main(void)
{
    int data[] = {1,2,3,4,5,6,7,8,9,10, 11};
    printf("%d\n", sum(data, sizeof(data)/sizeof(int)) );
    return 0;
}

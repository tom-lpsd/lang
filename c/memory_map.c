#include <stdio.h>

int main(void)
{
    char a[3][3] = {{'a','b','c'},
		    {'d','e','f'},
		    {'g','h','i'}};
    fwrite(a, sizeof(char), sizeof(a), stdout);

    printf("%c\n", a[0][1]);
    return 0;
}

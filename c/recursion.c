#include <stdio.h>
#include <stdlib.h>

int mystrlen_helper(char *str, int count)
{
    if (*str == '\0') {
        return count;
    }
    else {
        return mystrlen_helper(str+1, count + 1);
    }
}

int mystrlen(char *str)
{
    return mystrlen_helper(str, 0);
}

int main(void)
{
    char str[] = "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge"
        "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge"
        "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge"
        "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge"
        "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge"
        "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge"
        "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge"
        "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge"
        "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge"
        "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge"
        "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge"
        "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge"
        "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge"
        "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge"
        "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge"
        "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge"
        "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge"
        "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge"
        "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge"
        "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge"
        "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge"
        "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge"
        "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge"
        "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge"
        "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge"
        "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge"
        "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge"
        "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge"
        "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge"
        "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge"
        "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge"
        "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge"
        "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge"
        "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge"
        "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge"
        "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge"
        "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge"
        "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge"
        "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge"
        "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge"
        "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge"
        "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge"
        "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge"
        "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge"
        "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge"
        "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge"
        "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge"
        "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge"
        "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge"
        "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge"
        "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge"
        "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge"
        "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge"
        "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge"
        "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge"
        "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge"
        "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge"
        "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge"
        "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge"
        "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge"
        "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge"
        "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge"
        "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge"
        "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge"
        "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge"
        "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge"
        "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge"
        "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge"
        "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge"
        "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge"
        "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge"
        "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge"
        "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge"
        "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge"
        "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge"
        "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge"
        "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge"
        "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge"
        "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge"
        "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge"
        "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge"
        "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge"
        "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge"
        "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge"
        "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge"
        "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge"
        "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge"
        "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge"
        "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge"
        "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge"
        "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge"
        "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge"
        "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge"
        "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge"
        "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge"
        "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge"
        "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge"
        "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge"
        "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge"
        "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge"
        "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge" "hogehoge";

    int i = 0;
    for (i=0;i<100000;i++) {
        printf("%d\n", mystrlen(str));
    }
    return EXIT_SUCCESS;
}

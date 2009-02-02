#import <objc/Object.h>
#import <stdio.h>
#import <stdlib.h>
#import <string.h>

@interface Greeting : Object
{
    char *message;
}
- (Greeting *)init: (char *)msg;
- (void)free;
- (void)greet;
@end

@implementation Greeting
- (Greeting *)init: (char *)msg
{
    [super init];
    int len = strlen(msg) + 1;
    message = (char *)malloc(sizeof(char)*len);
    strcpy(message, msg);
    return self;
}

- (void)free
{
    free(message);
    [super free];
}

- (void)greet
{
    printf("%s\n", message);
}
@end

int main(void)
{
    char *msg = "Hello, World!";
    Greeting *g = [[Greeting alloc] init: msg];
    [g greet];
    SEL sel = @selector(init:);
    if ([g respondsTo: sel] == YES) {
	printf("OK\n");
    }
    [g free];
    return 0;
}

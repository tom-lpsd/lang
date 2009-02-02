#import <objc/Object.h>
#import <stdio.h>

@protocol Greeting
- (void)greet;
@end

@interface Greeter : Object <Greeting>
- (void)greet;
@end;

@implementation Greeter
- (void)greet
{
    printf("Hello, Protocol!\n");
}
@end

int main(void)
{
    Object <Greeting> *g = [[Greeter alloc] init];
    [g greet];
    [g free];
    return 0;
}

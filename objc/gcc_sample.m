#import <objc/Object.h>
#import <stdio.h>

@interface Foo : Object {
    int x, y;
}
- (void)print;
@end

@implementation Foo

- (void)print {
    printf("Foo: x=%d y=%d\n", self->x, self->y);
}

- (Foo*)init:(int)a foo:(int)b {
    x = a;
    y = b;
    return self;
}

@end

int main(void)
{
    id foo;
    foo = [[Foo alloc] init:10 foo:20];
    [foo print];
    [foo free];
    return 0;
}

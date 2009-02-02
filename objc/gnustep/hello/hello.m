#import <Foundation/Foundation.h>
#import <Foundation/NSObject.h>
#import <Foundation/NSAutoreleasePool.h>

@interface Foo : NSObject
{
    int f;
}
- (id)init: (int)i;
- (void)dealloc;
- (void)foo;
@end

@implementation Foo
- (id)init: (int)i
{
    f = i;
    return self;
}

- (void)foo
{
    NSLog(@"foo\n");
}
- (void)dealloc
{
    NSLog(@"dealloc Foo %d...\n", f);
    [super dealloc];
}
@end

id bar(void)
{
    return [[[Foo alloc] init: 20] autorelease];
}

int main(int argc, char *argv[])
{
    id foo, pool = [[NSAutoreleasePool alloc] init];

    foo = [[[Foo alloc] init: 10] autorelease];

    NSLog(@"Hello %@ %d\n", foo, [foo retainCount]);

    [bar() foo];

    [pool release];

    return 0;
}

#import <Foundation/Foundation.h>

@interface Person : NSObject
{
    NSString *name;
    NSString *email;
    int age;
}
- (void)setName:(NSString *)aName;
- (NSString *)email;
@end

@implementation Person

- (void)setName:(NSString *)aName
{
    NSLog(@"Access: setName:\n");
    [name autorelease];
    name = [aName retain];
}

- (NSString *)email
{
    NSLog(@"Access: email:\n");
    return email;
}

@end

int main(void)
{
    static NSString *keys[] = { @"name", @"email", @"age", nil};
    int i;
    id pool = [[NSAutoreleasePool alloc] init];
    id obj = [[Person alloc] init];

    [obj setValue:@"Taro" forKey:@"name"];
    [obj setValue:@"taro@ryugu-jo" forKey:@"email"];
    [obj setValue:[NSNumber numberWithInt:16] forKey:@"age"];

    for (i=0; keys[i]; i++) {
	NSLog(@"%@: %@\n", keys[i], [obj valueForKey:keys[i]]);
    }

    [pool release];
    return 0;
}

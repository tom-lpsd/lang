#import <Foundation/Foundation.h>

@class Company;

@interface Book : NSObject
{
    int id;
    NSString *name;
    id company;
}
- (id)initWithName:(NSString *)name company:(Company *)com;
@end

@implementation Book
static int max_book_id = 0;

- (id)initWithName:(NSString *)aName company:(Company *)com
{
    self->id = ++max_book_id;
    name = aName;
    company = com;
    return self;    
}
@end

@interface Company : NSObject
{
    int id;
    NSString *name;
}
- (id)initWithName:(NSString *)name;
@end

@implementation Company
static int max_company_id = 0;

- (id)initWithName:(NSString *)aName
{
    self->id = ++max_company_id;
    name = aName;
    return self;
}
@end

int main(void)
{
    id pool = [[NSAutoreleasePool alloc] init];

    Company *com = [[Company alloc] initWithName:@"O'reilly"];
    Book *book = [[Book alloc] initWithName:@"Programming Perl" company:com];

    NSLog(@"%@\n", [book valueForKeyPath:@"company.name"]);

    [book release];
    [com release];
    [pool release];

    return 0;
}

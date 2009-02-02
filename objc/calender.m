#import <Foundation/Foundation.h>

int main(int argc, const char *argv[])
{
    int n;
    NSCalendarDate *date;
    NSAutoreleasePool *pool;
    pool = [[NSAutoreleasePool alloc] init];

    date = [NSCalendarDate calendarDate];
    NSLog(@"%d\n", [date dayOfCommonEra]);

    [pool release];
    return 0;
}

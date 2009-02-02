#import <Foundation/Foundation.h>
#import "LotteryEntry.h"

int main (int argc, const char * argv[]) {
	NSMutableArray *array;
	int i;
	LotteryEntry *entry;
	
	NSCalendarDate *now;
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];

	now = [[NSCalendarDate alloc] init];
	srandom(time(NULL));
	array = [[NSMutableArray alloc] init];
	
	for (i=0;i<10;i++) {
		entry = [[LotteryEntry alloc] init];
		[entry setNumbersRandomly];
		[entry setEntryDate: [now dateByAddingYears:0 months:0 days:(i*7)
											  hours:0 minutes:0 seconds:0]];
		[array addObject:entry];
		[entry release];
	}
    // insert code here...
    NSLog(@"array = %@", array);
	
	[array release];
	[now release];
    [pool release];
    return 0;
}

//
//  LotteryEntry.m
//  lottery
//
//  Created by 鶴原 翔夢 on 08/02/16.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "LotteryEntry.h"


@implementation LotteryEntry
- (void)setNumbersRandomly
{
	firstNumber = random() % 100 + 1;
	secondNumber = random() % 100 + 1;
}

- (void)setEntryDate: (NSCalendarDate *)date
{
	[date retain];
	[entryDate release];
	[date setCalendarFormat:@"%b %d, %Y"];
	entryDate = date;
}

- (NSCalendarDate *)entryDate
{
	return entryDate;
}

- (int)firstNumber
{
	return firstNumber;
}

- (int)secondNumber
{
	return secondNumber;
}

- (void)dealloc
{
	NSLog(@"Destroying %@", self);
	[entryDate release];
	[super dealloc];
}

- (NSString *)description
{
	return [NSString stringWithFormat: @"%@ = %d and %d", 
		[self entryDate], [self firstNumber], [self secondNumber]];
}
@end

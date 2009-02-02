//
//  LotteryEntry.h
//  lottery
//
//  Created by 鶴原 翔夢 on 08/02/16.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface LotteryEntry : NSObject {
	NSCalendarDate *entryDate;
	int firstNumber;
	int secondNumber;
}
- (void)setNumbersRandomly;
- (void)setEntryDate:(NSCalendarDate *)date;
- (NSCalendarDate *)entryDate;
- (int)firstNumber;
- (int)secondNumber;
@end

//
//  NSDateComponents.m
//  XLFCommonKit
//
//  Created by Marike Jave on 15/8/26.
//  Copyright (c) 2015年 Marike Jave. All rights reserved.
//

#import "NSDateComponents+Categories.h"

#import "CategoryMacros.h"

CategoryKit_LoadCategory(NSDateComponents_Categories)

@implementation NSDateComponents(Categories)

+ (NSDateComponents*)componentsWithDateComponents:(NSDateComponents *)dateComponents;{
    NSDateComponents *cloneDateComponents = [[NSDateComponents alloc] init];
    [cloneDateComponents clone:dateComponents];
    return cloneDateComponents;
}


- (void)clone:(NSDateComponents*)dateComponents;{
    [self setCalendar:[dateComponents calendar]];
    [self setTimeZone:[dateComponents timeZone]];
    [self setEra:[dateComponents era]];
    [self setYear:[dateComponents year]];
    [self setMonth:[dateComponents month]];
    [self setDay:[dateComponents day]];
    [self setHour:[dateComponents hour]];
    [self setMinute:[dateComponents minute]];
    [self setSecond:[dateComponents second]];
    [self setNanosecond:[dateComponents nanosecond]];
    [self setWeekday:[dateComponents weekday]];
    [self setWeekdayOrdinal:[dateComponents weekdayOrdinal]];
    [self setQuarter:[dateComponents quarter]];
    [self setWeekOfMonth:[dateComponents weekOfMonth]];
    [self setWeekOfYear:[dateComponents weekOfYear]];
    [self setYearForWeekOfYear:[dateComponents yearForWeekOfYear]];
    [self setLeapMonth:[dateComponents isLeapMonth]];
}

- (void)monthOffset:(NSInteger)offset;{
    NSInteger month = offset + [self month];
    if (month <= 0 || month > 12) {
        NSInteger yearOffset = labs(month) / 12;
        NSInteger monthOffset = labs(month) % 12;
        if (month<=0) {
            [self setYear:[self year] - yearOffset - 1];
            [self setMonth:12 - monthOffset];
        } else {
            [self setYear:[self year] + yearOffset];
            [self setMonth:monthOffset];
        }
    } else {
        [self setMonth:month];
    }
}

+ (NSDateComponents*)nowDateComponents:(NSCalendarUnit)unitFlags;{
    return [self components:unitFlags fromDate:[NSDate date]];
}

+ (NSDateComponents*)components:(NSCalendarUnit)unitFlags fromDate:(NSDate*)date;{
    return [[NSCalendar currentCalendar] components:unitFlags fromDate:date];
}

- (NSDate *)date;{
    return [[NSCalendar currentCalendar] dateFromComponents:self];
}

@end

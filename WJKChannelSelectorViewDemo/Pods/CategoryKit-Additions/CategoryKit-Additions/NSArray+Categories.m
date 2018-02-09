//
//  NSArray+Extended.m
//  XLFCommonKit
//
//  Created by Marike Jave on 14-3-17.
// Copyright (c) 2014年 Marike Jave. All rights reserved.
//

#import "NSArray+Categories.h"

#import "CategoryMacros.h"

CategoryKit_LoadCategory(NSArray)

@implementation NSArray (Categories)

- (id)objectAtIndexWithSafety:(NSUInteger)index{
    if ([self count] > index) {
        return [self objectAtIndex:index];
    }
    return nil;
}

@end

@implementation NSMutableArray (Categories)

- (void)intersectSet:(NSArray *)otherArray;{
    NSMutableSet *etSelfSet = [NSMutableSet setWithArray:[self copy]];
    NSSet *etOtherSet = [NSSet setWithArray:[otherArray copy]];
    [etSelfSet intersectSet:etOtherSet];
    [self setArray:[etSelfSet allObjects]];
}

- (void)minusSet:(NSArray *)otherArray;{
    NSMutableSet *etSelfSet = [NSMutableSet setWithArray:[self copy]];
    NSSet *etOtherSet = [NSSet setWithArray:[otherArray copy]];
    [etSelfSet minusSet:etOtherSet];
    [self setArray:[etSelfSet allObjects]];
}

- (void)unionSet:(NSArray *)otherArray;{
    NSMutableSet *etSelfSet = [NSMutableSet setWithArray:[self copy]];
    NSSet *etOtherSet = [NSSet setWithArray:[otherArray copy]];
    [etSelfSet unionSet:etOtherSet];
    [self setArray:[etSelfSet allObjects]];
}

@end

@implementation NSArray (JSONSerializing)

- (NSData *)JSONData;{
    return [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil];
}

- (NSData *)JSONDataWithOptions:(NSJSONWritingOptions)options error:(NSError **)error;{
    return [NSJSONSerialization dataWithJSONObject:self options:options error:error];
}

- (NSString *)JSONString;{
    return [[NSString alloc] initWithData:[self JSONData] encoding:NSUTF8StringEncoding];
}

- (NSString *)JSONStringWithOptions:(NSJSONWritingOptions)options error:(NSError **)error;{
    return [[NSString alloc] initWithData:[self JSONDataWithOptions:options error:error] encoding:NSUTF8StringEncoding];
}

@end

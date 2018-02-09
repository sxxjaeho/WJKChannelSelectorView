//
//  NSIndexSet+Categories.m
//  XLFCommonKit
//
//  Created by Marike Jave on 15/11/25.
//  Copyright © 2015年 Marike Jave. All rights reserved.
//
#import <UIKit/UIKit.h>

#import "NSIndexSet+Categories.h"
#import "CategoryMacros.h"

CategoryKit_LoadCategory(NSIndexSet_Categories)

@implementation NSIndexSet (Categories)

+ (NSArray *)indexSetsFromIndex:(NSInteger)nIndex count:(NSInteger)count;{
    NSMutableArray *indexSets = [NSMutableArray array];
    for (NSInteger from = 0; from < count; from++) {
        [indexSets addObject:[NSIndexSet indexSetWithIndex:nIndex + from]];
    }
    return indexSets;
}

- (NSArray *)indexPaths;{
    NSMutableArray *indexPaths = [NSMutableArray array];
    [self enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
        [indexPaths addObject:[NSIndexPath indexPathForRow:idx inSection:0]];
    }];
    return indexPaths;
}

@end

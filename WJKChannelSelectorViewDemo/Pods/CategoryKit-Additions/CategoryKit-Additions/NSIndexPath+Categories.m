//
//  NSIndexPath+Categories.m
//  XLFCommonKit
//
//  Created by Marike Jave on 15/11/25.
//  Copyright © 2015年 Marike Jave. All rights reserved.
//

#import "NSIndexPath+Categories.h"
#import "CategoryMacros.h"

CategoryKit_LoadCategory(NSIndexPath_Categories)

@implementation NSIndexPath(Categories)

+ (NSArray *)indexPathsInSection:(NSInteger)section fromIndex:(NSInteger)nIndex count:(NSInteger)count;{
    NSMutableArray *indexPaths = [NSMutableArray array];
    for (NSInteger from = 0; from < count; from++) {
        [indexPaths addObject:[NSIndexPath indexPathForRow:nIndex + from inSection:section]];
    }
    return indexPaths;
}

+ (NSArray *)indexPathsFromIndex:(NSInteger)nIndex count:(NSInteger)count;{
    return [self indexPathsInSection:0 fromIndex:nIndex count:count];
}

@end

//
//  NSObject+Categories.m
//  XLFCommonKit
//
//  Created by Marike Jave on 15/3/23.
//  Copyright (c) 2015年 Marike Jave. All rights reserved.
//

#import "NSObject+Categories.h"

#import <objc/runtime.h>
#import "CategoryMacros.h"

CategoryKit_LoadCategory(NSObject_Categories)

@implementation NSObject(Categories)

+ (instancetype)object;{
    return [[[self class] alloc] init];
}

@end

//
//  NSBundle+Categories.h
//  XLFCommonKit
//
//  Created by Marike Jave on 14-10-27.
//  Copyright (c) 2014年 Marike Jave. All rights reserved.
//

#import "NSBundle+Categories.h"
#import "CategoryMacros.h"

CategoryKit_LoadCategory(NSBundle_Categories)

@implementation NSBundle(Categories)

+ (void)load{
    [super load];
    NSLog(@"%@", [[[NSBundle mainBundle] infoDictionary] description]);
}

/**
 *  获取应用名称
 *  @return 应用名称
 */

+ (NSString *)bundleDisplayName{

    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];//获取info－plist
}

/**
 *  获取应用标识号
 *  @return 标识号
 */

+ (NSString *)bundleIdentifier{

    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];//获取info－plist
}

/**
 *  获取应用版本
 *  @return 版本号
 */

+ (NSString *)appVersion{

    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];//获取info－plist
}

/**
 *  获取Bundle版本
 *  @return 版本号
 */

+ (NSString *)bundleVersion;{

    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];//获取info－plist
}

@end

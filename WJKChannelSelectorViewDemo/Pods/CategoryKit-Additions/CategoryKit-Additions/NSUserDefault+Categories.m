//
//  NSUserDefault+Extended.m
//  XLFCommonKit
//
//  Created by Marike Jave on 14-8-28.
//  Copyright (c) 2014年 Marike Jave. All rights reserved.
//

#import "NSUserDefault+Categories.h"
#import "CategoryMacros.h"

CategoryKit_LoadCategory(NSUserDefaults_Categories)


@implementation NSUserDefaults(standardUserDefaults)

+ (id)objectForKey:(NSString *)defaultName;{
    return [[NSUserDefaults standardUserDefaults] objectForKey:defaultName];
}

+ (void)setObject:(id)value forKey:(NSString *)defaultName;{
    [[NSUserDefaults standardUserDefaults] setObject:value
                                              forKey:defaultName];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)removeObjectForKey:(NSString *)defaultName;{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:defaultName];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)stringForKey:(NSString *)defaultName;{
    return [[NSUserDefaults standardUserDefaults] stringForKey:defaultName];
}

+ (NSArray *)arrayForKey:(NSString *)defaultName;{
    return [[NSUserDefaults standardUserDefaults] arrayForKey:defaultName];
}

+ (NSDictionary *)dictionaryForKey:(NSString *)defaultName;{
    return [[NSUserDefaults standardUserDefaults] dictionaryForKey:defaultName];
}

+ (NSData *)dataForKey:(NSString *)defaultName;{
    return [[NSUserDefaults standardUserDefaults] dataForKey:defaultName];
}

+ (NSArray *)stringArrayForKey:(NSString *)defaultName;{
    return [[NSUserDefaults standardUserDefaults] stringArrayForKey:defaultName];
}

+ (NSInteger)integerForKey:(NSString *)defaultName;{
    return [[NSUserDefaults standardUserDefaults] integerForKey:defaultName];
}

+ (float)floatForKey:(NSString *)defaultName;{
    return [[NSUserDefaults standardUserDefaults] floatForKey:defaultName];
}

+ (double)doubleForKey:(NSString *)defaultName;{
    return [[NSUserDefaults standardUserDefaults] doubleForKey:defaultName];
}

+ (BOOL)boolForKey:(NSString *)defaultName;{
    return [[NSUserDefaults standardUserDefaults] boolForKey:defaultName];
}

+ (NSURL *)URLForKey:(NSString *)defaultName NS_AVAILABLE(10_6, 4_0);{
    return [[NSUserDefaults standardUserDefaults] URLForKey:defaultName];
}

+ (void)setInteger:(NSInteger)value forKey:(NSString *)defaultName;{
    [[NSUserDefaults standardUserDefaults] setInteger:value
                                               forKey:defaultName];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)setFloat:(float)value forKey:(NSString *)defaultName;{
    [[NSUserDefaults standardUserDefaults] setFloat:value
                                             forKey:defaultName];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)setDouble:(double)value forKey:(NSString *)defaultName;{
    [[NSUserDefaults standardUserDefaults] setDouble:value
                                              forKey:defaultName];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)setBool:(BOOL)value forKey:(NSString *)defaultName;{
    [[NSUserDefaults standardUserDefaults] setBool:value
                                            forKey:defaultName];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)setURL:(NSURL *)url forKey:(NSString *)defaultName NS_AVAILABLE(10_6, 4_0);{
    [[NSUserDefaults standardUserDefaults] setURL:url
                                           forKey:defaultName];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end

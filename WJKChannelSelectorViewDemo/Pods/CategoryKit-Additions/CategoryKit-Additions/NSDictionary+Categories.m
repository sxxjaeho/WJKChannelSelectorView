//
//  NSDictionary+Categories.m
//  XLFCommonKit
//
//  Created by Marike Jave on 14-10-29.
//  Copyright (c) 2014年 Marike Jave. All rights reserved.
//

#import "NSDictionary+Categories.h"
#import "CategoryMacros.h"

CategoryKit_LoadCategory(NSDictionary_Categories)

@implementation NSDictionary(Geometry)

/**
 *  转换成CGRect
 *
 *  @param @{@"x":@10,@"y":@100,@"width":@100,@"height":@100}
 *
 *  @return
 */
- (CGRect)rectValue;{
    CGFloat x = [[self objectForKey:@"x"] floatValue];
    CGFloat y = [[self objectForKey:@"y"] floatValue];
    CGFloat width = [[self objectForKey:@"width"] floatValue];
    CGFloat height = [[self objectForKey:@"height"] floatValue];
    return CGRectMake(x, y, width, height);
}

/**
 *  转换成CGPoint
 *
 *  @param @{@"x":@10,@"y":@100}
 *
 *  @return
 */
- (CGPoint)pointValue;{
    CGFloat x = [[self objectForKey:@"x"] floatValue];
    CGFloat y = [[self objectForKey:@"y"] floatValue];
    return CGPointMake(x, y);
}

/**
 *  转换成CGSize
 *
 *  @param @{@"width":@100,@"height":@100}
 *
 *  @return
 */
- (CGSize)sizeValue;{
    CGFloat width = [[self objectForKey:@"width"] floatValue];
    CGFloat height = [[self objectForKey:@"height"] floatValue];
    return CGSizeMake(width, height);
}

@end

@implementation NSDictionary (JSONSerializing)

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

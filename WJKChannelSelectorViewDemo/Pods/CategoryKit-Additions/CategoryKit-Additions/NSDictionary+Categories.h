//
//  NSDictionary+Categories.h
//  XLFCommonKit
//
//  Created by Marike Jave on 14-10-29.
//  Copyright (c) 2014年 Marike Jave. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface NSDictionary (Geometry)

/**
 *  转换成CGRect @{@"x":@10,@"y":@100,@"width":@100,@"height":@100}
 *
 *  @return CGRect
 */
- (CGRect)rectValue;

/**
 *  转换成CGPoint @{@"x":@10,@"y":@100}
 *
 *  @return CGPoint
 */
- (CGPoint)pointValue;

/**
 *  转换成CGSize @{@"width":@100,@"height":@100}
 *
 *  @return return
 */
- (CGSize)sizeValue;

@end

@interface NSDictionary (JSONSerializing)
- (NSData *)JSONData;
- (NSData *)JSONDataWithOptions:(NSJSONWritingOptions)options error:(NSError **)error;
- (NSString *)JSONString;
- (NSString *)JSONStringWithOptions:(NSJSONWritingOptions)options error:(NSError **)error;
@end

//
//  UIColor+Categories.h
//  XLFCommonKit
//
//  Created by Marike Jave on 14-8-25.
//  Copyright (c) 2014年 Marike Jave. All rights reserved.
//
#import "UIColor+Categories.h"
#import "CategoryMacros.h"

CategoryKit_LoadCategory(UIColor_Categories)

@implementation UIColor (Transform)

/**
 *  16进制颜色转换成UIColor
 *
 *  @param hexValue 16进制颜色
 *
 *  @return UIColor
 */
+(UIColor *)colorWithHexRGB:(NSUInteger)hexValue{
    return [self colorWithHexRGB:hexValue alpha:1];
}
/**
 *  16进制颜色转换成UIColor
 *
 *  @param hexValue 16进制颜色
 *
 *  @return UIColor
 */
+(UIColor *)colorWithHexRGBA:(NSUInteger)hexValue{
    return [self colorWithHexRGB:hexValue alpha:((hexValue >> 24) & 0x000000FF)/255.0f];
}
/**
 *  16进制颜色转换成UIColor
 *
 *  @param hexValue 16进制颜色
 *  @param alpha    透明度
 *
 *  @return UIColor
 */
+(UIColor *)colorWithHexRGB:(NSUInteger)hexValue alpha:(CGFloat)alpha;{
    return UIColorWithRGBA(((hexValue >> 16) & 0x000000FF)/255.0,
                           ((hexValue >> 8) & 0x000000FF)/255.0f,
                           ((hexValue) & 0x000000FF)/255.0f,
                           alpha);
}
@end

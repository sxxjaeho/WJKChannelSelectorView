//
//  UIFont+Categories.m
//  XLFCommonKit
//
//  Created by Marike Jave on 14-9-2.
//  Copyright (c) 2014年 Marike Jave. All rights reserved.
//
#import "UIFont+Categories.h"
#import "CategoryMacros.h"

CategoryKit_LoadCategory(UIFont_Categories)

@implementation UIFont(Transform)

/**
 
 字体单位转换成像素
 pt   磅或点数，是point简称 1磅=0.03527厘米=1/72英寸inch 英寸，1英寸=2.54厘米=96像素（分辨率为96dpi）
 px   像素，pixel的简称（本表参照显示器96dbi显示进行换算。像素不能出现小数点，一般是取小显示）
 
 */
/**
 *  单位转换  像素  转换成 点
 *
 *  @param pixel 像素
 *
 *  @return 点
 */
+ (CGFloat) fontSizeFromPixel:(NSInteger)pixel;{
    return pixel / 96. * 72.;
}
/**
 *  单位转换  寸  转换成 点
 *
 *  @param inch 寸
 *
 *  @return 点
 */
+ (CGFloat) fontSizeFromInch:(CGFloat)inch;{
    return inch * 72.;
}
/**
 *  单位转换  毫米  转换成 点
 *
 *  @param millimeter 毫米
 *
 *  @return 点
 */
+ (CGFloat) fontSizeFromMillimeter:(CGFloat)millimeter;{
    return millimeter * 2.8;
}
/**
 *  通过像素值创建系统字体
 *
 *  @param pixel 像素
 *
 *  @return UIFont
 */
+ (UIFont *)systemFontOfPixel:(NSInteger)pixel;{
    return [self systemFontOfSize:[self fontSizeFromPixel:pixel]];
}
/**
 *  通过英寸值创建系统字体
 *
 *  @param inch 英寸
 *
 *  @return UIFont
 */
+ (UIFont *)systemFontOfInch:(CGFloat)inch;{
    return [self systemFontOfSize:[self fontSizeFromInch:inch]];
}
/**
 *  通过毫米值创建系统字体
 *
 *  @param millimeter 毫米
 *
 *  @return UIFont
 */
+ (UIFont *)systemFontOfMillimeter:(CGFloat)millimeter;{
    return [self systemFontOfSize:[self fontSizeFromMillimeter:millimeter]];
}
/**
 *  通过像素值创建系统加粗字体
 *
 *  @param pixel 像素
 *
 *  @return UIFont
 */
+ (UIFont *)boldSystemFontOfPixel:(NSInteger)pixel;{
    return [self boldSystemFontOfSize:[self fontSizeFromPixel:pixel]];
}
/**
 *  通过英寸值创建系统粗体字
 *
 *  @param inch 英寸
 *
 *  @return UIFont
 */
+ (UIFont *)boldSystemFontOfInch:(CGFloat)inch;{
    return [self boldSystemFontOfSize:[self fontSizeFromInch:inch]];
}
/**
 *  通过毫米值创建系统粗体字
 *
 *  @param millimeter 毫米
 *
 *  @return UIFont
 */
+ (UIFont *)boldSystemFontOfMillimeter:(CGFloat)millimeter;{
    return [self boldSystemFontOfSize:[self fontSizeFromMillimeter:millimeter]];
}
/**
 *  通过像素值创建系统斜体字
 *
 *  @param pixel 像素
 *
 *  @return UIFont
 */
+ (UIFont *)italicSystemFontOfPixel:(NSInteger)pixel;{
    return [self italicSystemFontOfSize:[self fontSizeFromPixel:pixel]];
}
/**
 *  通过英寸值创建系统斜体字
 *
 *  @param 英寸
 *
 *  @return UIFont
 */
+ (UIFont *)italicSystemFontOfInch:(CGFloat)inch;{
    return [self italicSystemFontOfSize:[self fontSizeFromInch:inch]];
}
/**
 *  通过毫米值创建系统斜体字
 *
 *  @param millimeter 毫米
 *
 *  @return UIFont
 */
+ (UIFont *)italicSystemFontOfMillimeter:(CGFloat)millimeter;{
    return [self italicSystemFontOfSize:[self fontSizeFromMillimeter:millimeter]];
}
/**
 *  通过字体名称和像素值创建字体
 *
 *  @param fontName 字体名称
 *  @param pixel    像素
 *
 *  @return UIFont
 */
+ (UIFont *)fontWithName:(NSString *)fontName pixel:(NSInteger)pixel;{
    return [self fontWithName:fontName size:[self fontSizeFromPixel:pixel]];
}
/**
 *  通过字体名称和英寸值创建字体
 *
 *  @param fontName 字体名称
 *  @param inch     英寸
 *
 *  @return UIFont
 */
+ (UIFont *)fontWithName:(NSString *)fontName inch:(CGFloat)inch;{
    return [self fontWithName:fontName size:[self fontSizeFromInch:inch]];
}
/**
 *  通过字体名称和毫米值创建字体
 *
 *  @param fontName     字体名称
 *  @param millimeter   毫米值
 *
 *  @return UIFont
 */
+ (UIFont *)fontWithName:(NSString *)fontName millimeter:(CGFloat)millimeter;{
    return [self fontWithName:fontName size:[self fontSizeFromMillimeter:millimeter]];
}
/**
 *  通过字体描述符和像素值创建字体
 *
 *  @param fontName     字体名称
 *  @param pixel        像素值
 *
 *  @return UIFont
 */
+ (UIFont *)fontWithDescriptor:(UIFontDescriptor *)descriptor pixel:(NSInteger)pixel;{
    return [self fontWithDescriptor:descriptor size:[self fontSizeFromPixel:pixel]];
}
/**
 *  通过字体描述符和英寸值创建字体
 *
 *  @param fontName     字体名称
 *  @param inch         英寸值
 *
 *  @return UIFont
 */
+ (UIFont *)fontWithDescriptor:(UIFontDescriptor *)descriptor inch:(CGFloat)inch;{
    return [self fontWithDescriptor:descriptor size:[self fontSizeFromInch:inch]];
}
/**
 *  通过字体描述符和毫米值创建字体
 *
 *  @param fontName     字体名称
 *  @param millimeter   毫米值
 *
 *  @return UIFont
 */
+ (UIFont *)fontWithDescriptor:(UIFontDescriptor *)descriptor millimeter:(CGFloat)millimeter;{
    return [self fontWithDescriptor:descriptor size:[self fontSizeFromMillimeter:millimeter]];
}

@end

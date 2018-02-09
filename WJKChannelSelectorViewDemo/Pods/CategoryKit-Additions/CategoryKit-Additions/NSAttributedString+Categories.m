//
//  NSAttributedString+Categories.m
//  XLFCommonKit
//
//  Created by Marike Jave on 15/1/30.
//  Copyright (c) 2015年 Marike Jave. All rights reserved.
//
#import <CoreText/CoreText.h>

#import "NSAttributedString+Categories.h"

#import "CategoryMacros.h"

CategoryKit_LoadCategory(NSAttributeString_Categories)

@implementation NSAttributedString(Categories)

- (CGFloat)widthWithLimitHeight:(CGFloat)height{

    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString( (CFAttributedStringRef)self);
    CGSize suggestedSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter,CFRangeMake(0, 0), NULL,CGSizeMake(CGFLOAT_MAX, height), NULL);
    CFRelease(framesetter);
    return suggestedSize.width;
}

- (CGFloat)heightWithLimitWidth:(CGFloat)width{

    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString( (CFAttributedStringRef)self);
    CGSize suggestedSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter,CFRangeMake(0, 0), NULL,CGSizeMake(width, CGFLOAT_MAX), NULL);
    CFRelease(framesetter);
    return suggestedSize.height;
}

@end

//
//  UILabel+Categories.m
//  XLFCommonKit
//
//  Created by Marike Jave on 14-11-1.
//  Copyright (c) 2014年 Marike Jave. All rights reserved.
//
#import "UILabel+Categories.h"
#import "CategoryMacros.h"

CategoryKit_LoadCategory(UILabel_Categories)


@implementation UILabel(Categories)

- (NSString *)textAlignmentString;{
    switch ([self textAlignment]) {
        case NSTextAlignmentLeft:
            return kCAAlignmentLeft;
        case NSTextAlignmentCenter:
            return kCAAlignmentCenter;
        case NSTextAlignmentRight:
            return kCAAlignmentRight;
        case NSTextAlignmentJustified:
            return kCAAlignmentJustified;
        case NSTextAlignmentNatural:
            return kCAAlignmentNatural;
    }
    return kCAAlignmentLeft;
}
@end

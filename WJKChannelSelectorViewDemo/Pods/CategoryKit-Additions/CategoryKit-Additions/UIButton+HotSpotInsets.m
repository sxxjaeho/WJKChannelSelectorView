//
//  UIButton+HotSpotInsets.m
//  UDrivingCustomer
//
//  Created by Marke Jave on 16/3/7.
//  Copyright © 2016年 Marike Jave. All rights reserved.
//

#import <objc/runtime.h>

#import "UIButton+HotSpotInsets.h"

@implementation UIButton (HotSpotInsets)

- (UIEdgeInsets)hotSpotInsets{
    NSValue *hotSpot = objc_getAssociatedObject(self, @selector(hotSpotInsets));
    if (hotSpot) {
        return [hotSpot UIEdgeInsetsValue];
    }
    return UIEdgeInsetsZero;
}

- (void)setHotSpotInsets:(UIEdgeInsets)hotSpotInsets{
    objc_setAssociatedObject(self, @selector(hotSpotInsets), [NSValue valueWithUIEdgeInsets:hotSpotInsets], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent*)withEvent{
    CGRect bounds = UIEdgeInsetsInsetRect([self bounds], [self hotSpotInsets]);
    return CGRectContainsPoint(bounds, point);
}

@end

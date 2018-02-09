//
//  UIImage+RTTint.m
//
//  Created by Ramon Torres on 7/3/13.
//  Copyright (c) 2013 Ramon Torres <raymondjavaxx@gmail.com>. All rights reserved.
//

#import "UIImage+RTTint.h"

@implementation UIImage (RTTint)

// Tint: Color
-(UIImage*)rt_tintedImageWithColor:(UIColor*)color {
    return [self rt_tintedImageWithColor:color alpha:1.0f];
}

// Tint: Color + alpha
-(UIImage*)rt_tintedImageWithColor:(UIColor*)color alpha:(CGFloat)alpha {
    CGRect rect = CGRectMake(0.0f, 0.0f, self.size.width, self.size.height);
    return [self rt_tintedImageWithColor:color rect:rect alpha:alpha];
}

// Tint: Color + Rect
-(UIImage*)rt_tintedImageWithColor:(UIColor*)color rect:(CGRect)rect {
    return [self rt_tintedImageWithColor:color rect:rect alpha:1.0f];
}

// Tint: Color + Rect + alpha
-(UIImage*)rt_tintedImageWithColor:(UIColor*)color rect:(CGRect)rect alpha:(CGFloat)alpha {
    CGRect imageRect = CGRectMake(0.0f, 0.0f, self.size.width, self.size.height);
    
    UIGraphicsBeginImageContextWithOptions(imageRect.size, NO, self.scale);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    [self drawInRect:imageRect];
    
    CGContextSetFillColorWithColor(ctx, [color CGColor]);
    CGContextSetAlpha(ctx, alpha);
    CGContextSetBlendMode(ctx, kCGBlendModeSourceAtop);
    CGContextFillRect(ctx, rect);
    
    CGImageRef imageRef = CGBitmapContextCreateImage(ctx);
    UIImage *darkImage = [UIImage imageWithCGImage:imageRef
                                             scale:self.scale
                                       orientation:self.imageOrientation];
    CGImageRelease(imageRef);
    
    UIGraphicsEndImageContext();
    
    return darkImage;
}

// Tint: Color + Insets
-(UIImage*)rt_tintedImageWithColor:(UIColor*)color insets:(UIEdgeInsets)insets {
    return [self rt_tintedImageWithColor:color insets:insets alpha:1.0f];
}

// Tint: Color + Insets + alpha
-(UIImage*)rt_tintedImageWithColor:(UIColor*)color insets:(UIEdgeInsets)insets alpha:(CGFloat)alpha {
    CGRect rect = CGRectMake(0.0f, 0.0f, self.size.width, self.size.height);
    return [self rt_tintedImageWithColor:color rect:UIEdgeInsetsInsetRect(rect, insets) alpha:alpha];
}

// Light: Level
-(UIImage*)rt_lightenWithLevel:(CGFloat)alpha {
    return [self rt_tintedImageWithColor:[UIColor whiteColor] alpha:alpha];
}

// Light: Level + Insets
-(UIImage*)rt_lightenWithLevel:(CGFloat)alpha insets:(UIEdgeInsets)insets {
    return [self rt_tintedImageWithColor:[UIColor whiteColor] insets:insets alpha:alpha];
}

// Light: Level + Rect
-(UIImage*)rt_lightenRect:(CGRect)rect withLevel:(CGFloat)alpha {
    return [self rt_tintedImageWithColor:[UIColor whiteColor] rect:rect alpha:alpha];
}

// Dark: Level
-(UIImage*)rt_darkenWithLevel:(CGFloat)alpha {
    return [self rt_tintedImageWithColor:[UIColor blackColor] alpha:alpha];
}

// Dark: Level + Insets
-(UIImage*)rt_darkenWithLevel:(CGFloat)alpha insets:(UIEdgeInsets)insets {
    return [self rt_tintedImageWithColor:[UIColor blackColor] insets:insets alpha:alpha];
}

// Dark: Level + Rect
-(UIImage*)rt_darkenRect:(CGRect)rect withLevel:(CGFloat)alpha {
    return [self rt_tintedImageWithColor:[UIColor blackColor] rect:rect alpha:alpha];
}

@end

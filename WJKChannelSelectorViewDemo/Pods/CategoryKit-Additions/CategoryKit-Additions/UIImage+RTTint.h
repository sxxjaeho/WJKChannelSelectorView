//
//  UIImage+RTTint.h
//
//  Created by Ramon Torres on 7/3/13.
//  Copyright (c) 2013 Ramon Torres <raymondjavaxx@gmail.com>. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (RTTint)

-(UIImage*)rt_tintedImageWithColor:(UIColor*)color;
-(UIImage*)rt_tintedImageWithColor:(UIColor*)color alpha:(CGFloat)alpha;
-(UIImage*)rt_tintedImageWithColor:(UIColor*)color rect:(CGRect)rect;
-(UIImage*)rt_tintedImageWithColor:(UIColor*)color rect:(CGRect)rect alpha:(CGFloat)alpha;
-(UIImage*)rt_tintedImageWithColor:(UIColor*)color insets:(UIEdgeInsets)insets;
-(UIImage*)rt_tintedImageWithColor:(UIColor*)color insets:(UIEdgeInsets)insets alpha:(CGFloat)alpha;

-(UIImage*)rt_lightenWithLevel:(CGFloat)alpha;
-(UIImage*)rt_lightenWithLevel:(CGFloat)alpha insets:(UIEdgeInsets)insets;
-(UIImage*)rt_lightenRect:(CGRect)rect withLevel:(CGFloat)alpha;

-(UIImage*)rt_darkenWithLevel:(CGFloat)alpha;
-(UIImage*)rt_darkenWithLevel:(CGFloat)alpha insets:(UIEdgeInsets)insets;
-(UIImage*)rt_darkenRect:(CGRect)rect withLevel:(CGFloat)alpha;

@end

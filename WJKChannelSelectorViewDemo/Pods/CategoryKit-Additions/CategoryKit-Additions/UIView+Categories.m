//
//  UIView+Categories
//  XLFCommonKit
//
//  Created by Marike Jave on 14-8-28.
//  Copyright (c) 2014年 Marike Jave. All rights reserved.
//
#import "UIView+Categories.h"
#import <objc/runtime.h>
#import "CategoryMacros.h"

CategoryKit_LoadCategory(UIView_Categories)

@implementation CALayer(Extended)
- (void)setOrigin:(CGPoint)origin{
    CGRect frame = [self frame];
    frame.origin = origin;
    [self setFrame:frame];
}

- (CGPoint)origin{
    return [self frame].origin;
}

- (void)setSize:(CGSize)size{
    CGRect frame = [self frame];
    frame.size = size;
    [self setFrame:frame];
}

- (CGSize)size{
    return [self frame].size;
}

- (void)setLeft:(CGFloat)left{
    CGRect frame = [self frame];
    frame.origin.x = left;
    [self setFrame:frame];
}

- (CGFloat)left{
    return [self frame].origin.x;
}

- (void)setTop:(CGFloat)top{
    CGRect frame = [self frame];
    frame.origin.y = top;
    [self setFrame:frame];
}

- (CGFloat)top{
    return [self frame].origin.y;
}

- (CGPoint)termination{
    return CGPointMake([self right], [self bottom]);
}

- (CGFloat)right{
    return [self left] + [self width];
}

- (CGFloat)bottom{
    return [self top] + [self height];
}

- (void)setWidth:(CGFloat)width{
    CGRect frame = [self frame];
    frame.size.width = width;
    [self setFrame:frame];
}

- (CGFloat)width{
    return [self bounds].size.width;
}

- (void)setHeight:(CGFloat)height{
    CGRect frame = [self frame];
    frame.size.height = height;
    [self setFrame:frame];
}

- (CGFloat)height{
    return [self bounds].size.height;
}
@end

@implementation UIView(Extended)
- (void)setOrigin:(CGPoint)origin{
    CGRect frame = [self frame];
    frame.origin = origin;
    [self setFrame:frame];
}

- (CGPoint)origin{
    return [self frame].origin;
}

- (void)setSize:(CGSize)size{
    CGRect frame = [self frame];
    frame.size = size;
    [self setFrame:frame];
}

- (CGSize)size{
    return [self frame].size;
}

- (void)setLeft:(CGFloat)left{
    CGRect frame = [self frame];
    frame.origin.x = left;
    [self setFrame:frame];
}

- (CGFloat)left{
    return [self frame].origin.x;
}

- (void)setTop:(CGFloat)top{
    CGRect frame = [self frame];
    frame.origin.y = top;
    [self setFrame:frame];
}

- (CGFloat)top{
    return [self frame].origin.y;
}

- (CGPoint)termination{
    return CGPointMake([self right], [self bottom]);
}

- (CGFloat)right{
    return [self left] + [self width];
}

- (CGFloat)bottom{
    return [self top] + [self height];
}

- (void)setWidth:(CGFloat)width{
    CGRect frame = [self frame];
    frame.size.width = width;
    [self setFrame:frame];
}

- (CGFloat)width{
    return [self bounds].size.width;
}

- (void)setHeight:(CGFloat)height{
    CGRect frame = [self frame];
    frame.size.height = height;
    [self setFrame:frame];
}

- (CGFloat)height{
    return [self bounds].size.height;
}

// 在UIView中递归查找指定Tag的UIView
- (UIView *)subViewWithTag:(NSInteger)tag;{
 
    UIView *reVal=nil;
    for (UIView *subView in [self subviews]) {

        if (subView.tag==tag) {

            reVal=subView;
            break;
        } else {
            reVal=[subView subViewWithTag:tag];
            if (reVal!=nil) {
                break;
            }
        }
    }
    return reVal;
}
@end

@implementation UIView(Create)

+(id)view;{

    return [[[self class] alloc] init];
}

+(id)emptyFrameView;{

    return [[[self class] alloc] initWithFrame:CGRectZero];
}

+(id)viewFromNib;{
    return [self viewFromNibName:NSStringFromClass([self class])];
}

+(id)viewFromNibName:(NSString*)nibName;{
    return [[[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil] firstObject];
}

@end

@interface UIView (LoadingProperties)

@property(nonatomic, strong) UIActivityIndicatorView *evaivLoading;

@end

@implementation UIView (LoadingProperties)

- (UIActivityIndicatorView *)evaivLoading{
    UIActivityIndicatorView *etaivLoading = objc_getAssociatedObject(self, @selector(evaivLoading));
    if (!etaivLoading) {
        etaivLoading = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        [etaivLoading setFrame:[self bounds]];
        [etaivLoading setBackgroundColor:[UIColor lightGrayColor]];
        objc_setAssociatedObject(self, @selector(evaivLoading), etaivLoading, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return etaivLoading;
}

- (void)setEvaivLoading:(UIActivityIndicatorView *)evaivLoading{
    objc_setAssociatedObject(self, @selector(evaivLoading), evaivLoading, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

@implementation UIView (Loading)

- (void)startLoading;{
    [self setUserInteractionEnabled:NO];
    if (![[self subviews] containsObject:[self evaivLoading]]) {
        [[self evaivLoading] setCenter:CGRectGetCenter([self bounds])];
        [self addSubview:[self evaivLoading]];
    }
    [[self evaivLoading] startAnimating];
}

- (void)stopLoading;{

    [[self evaivLoading] stopAnimating];
    [[self evaivLoading] removeFromSuperview];
    [self setEvaivLoading:nil];
    [self setUserInteractionEnabled:YES];
}

@end


CGRect CGRectMakePS(CGPoint pt, CGSize sz){
    return CGRectMake(pt.x, pt.y, sz.width, sz.height);
}

CGRect CGRectMakePWH(CGPoint pt, CGFloat width, CGFloat height){
    return CGRectMake(pt.x, pt.y, width, height);
}

CGRect CGRectMakeXYS(CGFloat x, CGFloat y, CGSize sz){
    return CGRectMake(x, y, sz.width, sz.height);
}

CGSize CGRectGetSize(CGRect rect){
    return rect.size;
}

CGPoint CGRectGetOrigin(CGRect rect){
    return rect.origin;
}

CGPoint CGRectGetCenter(CGRect rect){
    return CGPointMake(rect.origin.x + rect.size.width/2., rect.origin.y + rect.size.height/2.);
}

CGPoint CGRectGetTermination(CGRect rect){
    return CGPointMake(rect.origin.x + rect.size.width, rect.origin.y + rect.size.height);
}


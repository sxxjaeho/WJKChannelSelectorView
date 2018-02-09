//
//  UISearchBar+Categories.m
//  XLFCommonKit
//
//  Created by Marike Jave on 14-12-31.
//  Copyright (c) 2014年 Marike Jave. All rights reserved.
//

#import "UISearchBar+Categories.h"
#import "CategoryMacros.h"

CategoryKit_LoadCategory(UISearchBar_Categories)

@implementation UISearchBar (Categories)

- (UITextField*)textFieldInView:(UIView *)view;{
    for (UIView *subview in [view subviews]){
        if ([subview isKindOfClass:[UITextField class]]){
            return (UITextField*)subview;
        } else if ([subview subviews] && [[subview subviews] count]){
            UITextField *textField = [self textFieldInView:subview];
            if (textField) {
                return textField;
            }
        }
    }
    return nil;
}

- (UITextField*)textField;{
    return [self textFieldInView:self];
}

- (void)setFont:(UIFont *)font{
    [[self textField] setFont:font];
}

- (UIFont*)font{
    return [[self textField] font];
}

- (void)setTextColor:(UIColor *)textColor{
    [[self textField] setTextColor:textColor];
}

- (UIColor*)textColor{
    return [[self textField] textColor];
}

- (void)setBackgroundColor:(UIColor *)backgroundColor{
    [[self textField] setBackgroundColor:backgroundColor];
}

- (UIColor *)backgroundColor{
    return [[self textField] backgroundColor];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor{
    [[self textField] setValue:placeholderColor forKeyPath:@"_placeholderLabel.textColor"];
}

- (UIColor *)placeholderColor{
    return [[self textField] valueForKeyPath:@"__placeholderLabel.textColor"];
}
@end

//
//  UIAlertView+Categories.m
//  XLFCommonKit
//
//  Created by Marike Jave on 14-3-31.
//  Copyright (c) 2014年 Marike Jave. All rights reserved.
//
#import "UIAlertView+Categories.h"
#import "CategoryMacros.h"

CategoryKit_LoadCategory(UIAlertView_Categories)

@implementation UIAlertView (Categories)

+ (UIAlertView*)alertWithMessage:(NSString *)message;{
    return [self alertWithTitle:nil message:message];
}

+ (UIAlertView*)alertWithTitle:(NSString *)title message:(NSString *)message {
	return [self alertWithTitle:title message:message delegate:nil];
}

+ (UIAlertView*)alertWithTitle:(NSString *)title message:(NSString *)message delegate:delegate {
	return [self alertWithTitle:title message:message delegate:delegate tag:0];
}

+ (UIAlertView*)alertWithTitle:(NSString *)title message:(NSString *)message delegate:delegate tag:(NSInteger)tag{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:delegate
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil,nil];

    [alert setTag:tag];
    [alert show];
    return alert;
}

+ (UIAlertView*)alertWithTitle:(NSString *)title message:(NSString *)message delegate:delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:delegate
                                          cancelButtonTitle:cancelButtonTitle
                                          otherButtonTitles:nil,nil];
    
    if (otherButtonTitles) {
        [alert addButtonWithTitle:otherButtonTitles];
        va_list argp;
        va_start(argp, otherButtonTitles);
        NSString *etButtonTitle = nil;
        while((etButtonTitle = va_arg(argp, NSString*))) {
            [alert addButtonWithTitle:etButtonTitle];
        }
        va_end(argp);
    }

    [alert show];
    return alert;
}

@end

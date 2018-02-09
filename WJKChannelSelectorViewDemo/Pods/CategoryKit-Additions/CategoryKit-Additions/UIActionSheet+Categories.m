//
//  UIActionSheet+Categories.m
//  XLFCommonKit
//
//  Created by Marike Jave on 15/1/27.
//  Copyright (c) 2015年 Marike Jave. All rights reserved.
//

#import "UIActionSheet+Categories.h"
#import "CategoryMacros.h"

CategoryKit_LoadCategory(UIActionSheet_Categories)

@implementation UIActionSheet(Categories)

+ (UIActionSheet*)actionSheetWithTitle:(NSString *)title;{
    return [self actionSheetWithTitle:title delegate:nil];
}

+ (void)showActionSheetWithTitle:(NSString *)title;{
    [[self actionSheetWithTitle:title] showInView:[[UIApplication sharedApplication] keyWindow]];
}

+ (UIActionSheet*)actionSheetWithTitle:(NSString *)title delegate:(id<UIActionSheetDelegate>)delegate;{
    return [self actionSheetWithTitle:title delegate:delegate cancelButtonTitle:@"取消"];
}

+ (void)showActionSheetWithTitle:(NSString *)title delegate:(id<UIActionSheetDelegate>)delegate;{
    [[self actionSheetWithTitle:title delegate:delegate] showInView:[[UIApplication sharedApplication] keyWindow]];
}

+ (UIActionSheet*)actionSheetWithTitle:(NSString *)title delegate:(id<UIActionSheetDelegate>)delegate cancelButtonTitle:(NSString*)cancelButtonTitle;{
    return [[UIActionSheet alloc] initWithTitle:title delegate:delegate cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:nil otherButtonTitles:nil, nil];
}

+ (void)showActionSheetWithTitle:(NSString *)title delegate:(id<UIActionSheetDelegate>)delegate cancelButtonTitle:(NSString*)cancelButtonTitle;{
    [[self actionSheetWithTitle:title delegate:delegate cancelButtonTitle:cancelButtonTitle] showInView:[[UIApplication sharedApplication] keyWindow]];
}

+ (UIActionSheet*)actionSheetWithTitle:(NSString *)title delegate:(id<UIActionSheetDelegate>)delegate cancelButtonIndex:(NSInteger)nIndex buttonTitles:(NSString *)buttonTitles, ...;{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:title
                                                       delegate:delegate
                                              cancelButtonTitle:nil
                                         destructiveButtonTitle:nil
                                              otherButtonTitles:nil, nil];
    if (buttonTitles) {
        [sheet addButtonWithTitle:buttonTitles];
        va_list argp;
        va_start(argp, buttonTitles);
        NSString *etButtonTitle = nil;
        while((etButtonTitle = va_arg(argp, NSString*))) {
            [sheet addButtonWithTitle:etButtonTitle];
        }
        va_end(argp);
    }
    [sheet setCancelButtonIndex:nIndex];
    
    return sheet;
}

+ (UIActionSheet *)showInView:(UIView *)view
                        title:(NSString *)title
                     delegate:(id<UIActionSheetDelegate>)delegate
            cancelButtonTitle:(NSString *)cancelButtonTitle
       destructiveButtonTitle:(NSString *)destructiveButtonTitle
            otherButtonTitles:(NSString *)otherButtonTitles, ...;{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:title
                                                       delegate:delegate
                                              cancelButtonTitle:cancelButtonTitle
                                         destructiveButtonTitle:destructiveButtonTitle
                                              otherButtonTitles:nil, nil];
    if (otherButtonTitles) {
        [sheet addButtonWithTitle:otherButtonTitles];
        va_list argp;
        va_start(argp, otherButtonTitles);
        NSString *etButtonTitle = nil;
        while((etButtonTitle = va_arg(argp, NSString*))) {
            [sheet addButtonWithTitle:etButtonTitle];
        }
        va_end(argp);
    }
    [sheet showInView:view];
    return sheet;
}


@end

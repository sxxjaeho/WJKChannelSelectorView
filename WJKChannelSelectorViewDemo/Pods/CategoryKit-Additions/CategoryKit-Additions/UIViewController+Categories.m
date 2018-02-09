//
//  UIViewController+Categories.m
//  XLFCommonKit
//
//  Created by Marike Jave on 15/3/18.
//  Copyright (c) 2015年 Marike Jave. All rights reserved.
//

#import "UIViewController+Categories.h"
#import "CategoryMacros.h"

CategoryKit_LoadCategory(UIViewController__Categories)


@implementation UIViewController (Categories)

+ (id)viewController;{
    return [[[self class] alloc] init];
}

+ (id)viewControllerFromNib;{
    return [self viewControllerFromNib:NSStringFromClass([self class])];
}

+ (id)viewControllerFromNib:(NSString*)nibName;{
    return [[[self class] alloc] initWithNibName:nibName bundle:nil];
}

+ (id)viewControllerFromStoryboard:(NSString*)storyboardName;{
    return [self viewControllerFromStoryboard:storyboardName storyboardId:NSStringFromClass([self class])];
}

+ (id)viewControllerFromStoryboard:(NSString*)storyboardName storyboardId:(NSString*)storyboardId;{
    return [[UIStoryboard storyboardWithName:storyboardName bundle:nil] instantiateViewControllerWithIdentifier:storyboardId];
}

@end

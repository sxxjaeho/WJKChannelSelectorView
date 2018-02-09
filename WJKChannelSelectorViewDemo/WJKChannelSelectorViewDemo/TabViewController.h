//
//  TabViewController.h
//  WJKChannelSelectorViewDemo
//
//  Created by Zeaho on 2018/2/9.
//  Copyright © 2018年 Zeaho. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TabViewController : UIViewController

@property (nonatomic, copy) NSMutableDictionary *params;

- (void)reloadData;

@end

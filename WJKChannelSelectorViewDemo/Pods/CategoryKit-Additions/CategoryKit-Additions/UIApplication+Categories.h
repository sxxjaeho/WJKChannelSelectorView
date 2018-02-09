//
//  UIApplication+Categories.h
//  CategoryKit
//
//  Created by xulinfeng on 2016/11/10.
//  Copyright © 2016年 markejave. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIApplication (Categories)
/**
 *  打开HTTP连接
 *
 *  @param url 链接地址
 */
+ (void)openURL:(NSString*)url;

/**
 *  拨打电话
 *
 *  @param phoneNumber 电话号码
 */
+ (BOOL)dialPhoneNumber:(NSString*)phoneNumber enableBack:(BOOL)enable;

/**
 *  拨打电话
 *
 *  @param phoneNumber 电话号码
 */
+ (void)dialPhoneNumber:(NSString*)phoneNumber;

/**
 *  获取随机数
 *
 *  @param from 开始
 *  @param to   结束
 *
 *  @return 数字
 */
+ (int)randomNumber:(int)from to:(int)to;

@end

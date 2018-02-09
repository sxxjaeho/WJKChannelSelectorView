//
//  UIApplication+Categories.m
//  CategoryKit
//
//  Created by xulinfeng on 2016/11/10.
//  Copyright © 2016年 markejave. All rights reserved.
//

#import "UIApplication+Categories.h"
#import "UIDevice+Categories.h"

@implementation UIApplication (Categories)

+ (void)openURL:(NSString *)url{
    if (url) {
        if (![url hasPrefix:@"http://"] && [url hasPrefix:@"https://"] ) {
            url =  [@"http://%@" stringByAppendingString:url];
        }
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    }
}

+ (BOOL)dialPhoneNumber:(NSString *)phoneNumber enableBack:(BOOL)enable;{
    phoneNumber = [phoneNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone && !(([UIDevice deviceModelType] & UIDeviceModelPodAll) && YES)) {
        NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"telprompt:%@",phoneNumber]];
        if (enable) {
            static UIWebView *webView = nil;
            if (!webView) {
                webView = [[UIWebView alloc] initWithFrame:CGRectZero];
            }
            [webView loadRequest:[NSURLRequest requestWithURL:phoneURL]];
            return YES;
        } else {
            return [[UIApplication sharedApplication] openURL:phoneURL];
        }
    } else {
        NSLog(@"您的设备不支持打电话");
    }
    return NO;
}


+ (void)dialPhoneNumber:(NSString *)phoneNumber{
    [self dialPhoneNumber:phoneNumber enableBack:YES];
}

+ (int)randomNumber:(int)from to:(int)to{
    return (int)(from + (arc4random() % (to -from + 1)));
}

@end

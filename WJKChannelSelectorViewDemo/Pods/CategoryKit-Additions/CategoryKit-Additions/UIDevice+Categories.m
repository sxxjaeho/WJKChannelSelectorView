//
//  UIDevice+Categories.m
//  XLFCommonKit
//
//  Created by Marike Jave on 14-10-27.
//  Copyright (c) 2014年 Marike Jave. All rights reserved.
//

#import "UIDevice+Categories.h"

#import <sys/types.h>
#import <sys/sysctl.h>

#import "CategoryMacros.h"

CategoryKit_LoadCategory(UIDevice_Categories)

@implementation UIDevice(Categories)
/**
 *  获取设备标识号
 *  @return 设备标识号
 */
+ (NSString *)deviceIdentifier;{
    /** 初始化一个保存用户帐号的KeychainItemWrapper */
    //    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] initWithIdentifier:@"UUID"
    //                                                                       accessGroup:@"44YCQRLTQE.com.outbound.XLFCommonKit"];
    //    [wrapper resetKeychainItem];
    //    从keychain里取出帐号密码
    //    NSString *deviceIdentifier = [wrapper objectForKey:(__bridge id)(kSecValueData)];
    //
    //    if (![deviceIdentifier length]) {
    //
    //        deviceIdentifier = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    //
    //        //保存数据
    //        [wrapper setObject:deviceIdentifier forKey:(__bridge id)(kSecValueData)];
    //    }
    return [[[[UIDevice currentDevice] identifierForVendor] UUIDString] stringByReplacingOccurrencesOfString:@"-" withString:@""];
}
/**
 *  获取设备用户名
 *  @return 设备用户名
 */
+ (NSString*)deviceName{
    return [[UIDevice currentDevice] name];
}

/**
 *  获取设备类别
 *
 *  @return 设备类别
 */
+ (NSString *)deviceModel {
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *model = malloc(size);
    sysctlbyname("hw.machine", model, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:model encoding:NSUTF8StringEncoding];
    free(model);

    //If none was found, send the original string
    return platform;
}

/**
 *  获取设备类型
 *
 *  @return 设备类型
 */
+ (UIDeviceModel)deviceModelType;{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *model = malloc(size);
    sysctlbyname("hw.machine", model, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:model encoding:NSUTF8StringEncoding];
    free(model);
    if ([platform isEqual:@"i386"]||[platform isEqualToString:@"x86_64"])
        return UIDeviceModelSimulator;
    if ([platform isEqual:@"iPhone1,1"])
        return UIDeviceModelPhone1G;
    if ([platform isEqual:@"iPhone1,2"])
        return UIDeviceModelPhone3G;
    if ([platform isEqual:@"iPhone2,1"])
        return UIDeviceModelPhone3GS;

    if ([platform hasPrefix:@"iPhone3"]/*||[sDeviceModel isEqual:@"iPhone3,1"] || [sDeviceModel isEqual:@"iPhone3,2"] || [sDeviceModel isEqual:@"iPhone3,3"]*/)
        return UIDeviceModelPhone4;
    if ([platform hasPrefix:@"iPhone4"]/*[sDeviceModel isEqual:@"iPhone4,1"]*/)
        return UIDeviceModelPhone4S;

    if ([platform isEqual:@"iPhone5,1"] ||[platform isEqual:@"iPhone5,2"])
        return UIDeviceModelPhone5;
    if ([platform isEqual:@"iPhone5,3"] ||[platform isEqual:@"iPhone5,4"])
        return UIDeviceModelPhone5C;
    if ([platform hasPrefix:@"iPhone6"]/*[sDeviceModel isEqualToString:@"iPhone6,2"]||[sDeviceModel isEqualToString:@"iPhone6,1"]*/)
        return UIDeviceModelPhone5S;

    if ([platform hasPrefix:@"iPhone7,2"])
        return UIDeviceModelPhone6;

    if ([platform hasPrefix:@"iPhone7,1"])
        return UIDeviceModelPhone6Plus;
    if ([platform hasPrefix:@"iPhone8,2"])
        return UIDeviceModelPhone6s;
    if ([platform hasPrefix:@"iPhone8,1"])
        return UIDeviceModelPhone6sPlus;

    if ([platform hasPrefix:@"iPhone"]/*[sDeviceModel isEqualToString:@"iPhone6,2"]||[sDeviceModel isEqualToString:@"iPhone6,1"]*/)
        return UIDeviceModelPhone;

    if ([platform isEqual:@"iPod1,1"])
        return UIDeviceModelPod1;
    if ([platform isEqual:@"iPod2,1"])
        return UIDeviceModelPod2;
    if ([platform isEqual:@"iPod3,1"])
        return UIDeviceModelPod3;
    if ([platform isEqual:@"iPod4,1"])
        return UIDeviceModelPod4;
    if ([platform isEqual:@"iPod5,1"])
        return UIDeviceModelPod5;

    if ([platform isEqual:@"iPod"])
        return UIDeviceModelPod;
    if ([platform isEqual:@"iPad1,1"])
        return UIDeviceModelPadWifi;
    if ([platform isEqual:@"iPad1,2"])
        return UIDeviceModelPad3G;

    if ([platform isEqualToString:@"iPad2,1"]||[platform isEqualToString:@"iPad2,2"]||
        [platform isEqualToString:@"iPad2,3"]||[platform isEqualToString:@"iPad2,4"])
        return UIDeviceModelPad2;
    if ([platform isEqualToString:@"iPad2,5"]||[platform isEqualToString:@"iPad2,6"]||
        [platform isEqualToString:@"iPad2,7"])
        return UIDeviceModelPadMini1G;
    if ([platform isEqualToString:@"iPad3,1"]||[platform isEqualToString:@"iPad3,2"]||
        [platform isEqualToString:@"iPad3,3"]||[platform isEqualToString:@"iPad3,4"]||
        [platform isEqualToString:@"iPad3,5"]||[platform isEqualToString:@"iPad3,6"])
        return UIDeviceModelPad3;

    if ([platform isEqualToString:@"iPad3,1"]||[platform isEqualToString:@"iPad3,2"]||
        [platform isEqualToString:@"iPad3,3"])
        return UIDeviceModelPad3;

    if([platform isEqualToString:@"iPad3,4"]||[platform isEqualToString:@"iPad3,5"]||
       [platform isEqualToString:@"iPad3,6"])
        return UIDeviceModelPad4;

    if ([platform isEqualToString:@"iPad4,1"]||[platform isEqualToString:@"iPad4,2"]||
        [platform isEqualToString:@"iPad4,3"])
        return UIDeviceModelPadAir;

    if ([platform isEqualToString:@"iPad4,4"]||[platform isEqualToString:@"iPad4,5"]||
        [platform isEqualToString:@"iPad4,6"])
        return UIDeviceModelPadAirMiniRetina;

    if ([platform isEqualToString:@"iPad5"])
        return UIDeviceModelPadAir2;

    if ([platform isEqualToString:@"iPad6"])
        return UIDeviceModelPadPro;

    if ([platform isEqual:@"iPad"])
        return UIDeviceModelPad;

    if ([platform isEqual:@"iWatch"])
        return UIDeviceModelWatch;

    return UIDeviceModelUnknown;
}

/**
 *  获取设备类别版
 *
 *  @return 设备类别版本
 */
+ (NSString *)deviceLocalizedModel;{
    return [[UIDevice currentDevice] localizedModel];
}
/**
 *  获取设备操作系统名称
 *
 *  @return 设备操作系统名称
 */
+ (NSString *)deviceSystemName;{
    return [[UIDevice currentDevice] systemName];
}
/**
 *  获取设备操作系统版本
 *
 *  @return 获取设备操作系统版本
 */
+ (NSString *)deviceSystemVersion;{
    return [[UIDevice currentDevice] systemVersion];
}
@end

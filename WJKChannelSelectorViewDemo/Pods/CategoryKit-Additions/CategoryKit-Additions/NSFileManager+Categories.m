//
//  NSFileManager+Categories.m
//  XLFCommonKit
//
//  Created by Marike Jave on 14-11-22.
//  Copyright (c) 2014年 Marike Jave. All rights reserved.
//

#import "NSFileManager+Categories.h"
#import "CategoryMacros.h"

CategoryKit_LoadCategory(NSFileManager_Categories)

@implementation NSFileManager(Categories)

+ (BOOL)fileExistsAtPath:(NSString *)path;{
    NSLog(@"judge whether the path exsits:%@", path);
    return [[NSFileManager defaultManager] fileExistsAtPath:path];
}

+ (BOOL)fileExistsAtPath:(NSString *)path isDirectory:(BOOL *)isDirectory;{
    NSLog(@"judge whether the path/directory exsits:%@", path);
    return [[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:isDirectory];
}

+ (BOOL)isReadableFileAtPath:(NSString *)path;{

    return [[NSFileManager defaultManager] isReadableFileAtPath:path];
}

+ (BOOL)isWritableFileAtPath:(NSString *)path;{

    return [[NSFileManager defaultManager] isWritableFileAtPath:path];
}

+ (BOOL)isExecutableFileAtPath:(NSString *)path;{

    return [[NSFileManager defaultManager] isExecutableFileAtPath:path];
}

+ (BOOL)isDeletableFileAtPath:(NSString *)path;{

    return [[NSFileManager defaultManager] isDeletableFileAtPath:path];
}

+ (BOOL)isFileAtPath:(NSString *)path error:(NSError **)error;{

    BOOL isDirectory = NO;
    BOOL isExsits = [[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDirectory];

    if (!isExsits && error) {

        *error = [NSError errorWithDomain:@"error:directory is not exsit!" code:0 userInfo:nil];
    }

    return isExsits && !isDirectory;
}

+ (BOOL)isFolderAtPath:(NSString *)path error:(NSError **)error;{

    BOOL isDirectory = NO;
    BOOL isExsits = [[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDirectory];

    if (!isExsits && error) {

        *error = [NSError errorWithDomain:@"error:directory is not exsit!" code:0 userInfo:nil];
    }
    return isExsits && isDirectory;
}

+ (BOOL)createDirectoryAtPath:(NSString *)path withIntermediateDirectories:(BOOL)createIntermediates attributes:(NSDictionary *)attributes error:(NSError **)error NS_AVAILABLE(10_5, 2_0);{
    NSLog(@"create directory at path:%@", path);
    return [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:createIntermediates attributes:attributes error:error];
}

+ (BOOL)createFileAtPath:(NSString *)path contents:(NSData *)data attributes:(NSDictionary *)attr;{

    return [[NSFileManager defaultManager] createFileAtPath:path contents:data attributes:attr];
}

+ (BOOL)copyItemAtPath:(NSString *)srcPath toPath:(NSString *)dstPath error:(NSError **)error NS_AVAILABLE(10_5, 2_0);{

    return [[NSFileManager defaultManager] copyItemAtPath:srcPath toPath:dstPath error:error];
}

+ (BOOL)moveItemAtPath:(NSString *)srcPath toPath:(NSString *)dstPath error:(NSError **)error NS_AVAILABLE(10_5, 2_0);{

    return [[NSFileManager defaultManager] moveItemAtPath:srcPath toPath:dstPath error:error];
}

+ (BOOL)linkItemAtPath:(NSString *)srcPath toPath:(NSString *)dstPath error:(NSError **)error NS_AVAILABLE(10_5, 2_0);{

    return [[NSFileManager defaultManager] linkItemAtPath:srcPath toPath:dstPath error:error];
}

+ (BOOL)removeItemAtPath:(NSString *)path error:(NSError **)error NS_AVAILABLE(10_5, 2_0);{

    return [[NSFileManager defaultManager] removeItemAtPath:path error:error];
}

+ (BOOL)copyItemAtURL:(NSURL *)srcURL toURL:(NSURL *)dstURL error:(NSError **)error NS_AVAILABLE(10_6, 4_0);{

    return [[NSFileManager defaultManager] copyItemAtURL:srcURL toURL:dstURL error:error];
}

+ (BOOL)moveItemAtURL:(NSURL *)srcURL toURL:(NSURL *)dstURL error:(NSError **)error NS_AVAILABLE(10_6, 4_0);{

    return [[NSFileManager defaultManager] moveItemAtURL:srcURL toURL:dstURL error:error];
}

+ (BOOL)linkItemAtURL:(NSURL *)srcURL toURL:(NSURL *)dstURL error:(NSError **)error NS_AVAILABLE(10_6, 4_0);{

    return [[NSFileManager defaultManager] linkItemAtURL:srcURL toURL:dstURL error:error];
}

+ (BOOL)removeItemAtURL:(NSURL *)URL error:(NSError **)error NS_AVAILABLE(10_6, 4_0);{

    return [[NSFileManager defaultManager] removeItemAtURL:URL error:error];
}

+ (NSArray *)contentsOfDirectoryAtPath:(NSString *)path error:(NSError **)error NS_AVAILABLE(10_5, 2_0);{

    return [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:error];
}

+ (NSArray *)subpathsOfDirectoryAtPath:(NSString *)path error:(NSError **)error NS_AVAILABLE(10_5, 2_0);{

    return [[NSFileManager defaultManager] subpathsOfDirectoryAtPath:path error:error];
}

+ (NSDictionary *)attributesOfItemAtPath:(NSString *)path error:(NSError **)error NS_AVAILABLE(10_5, 2_0);{

    return [[NSFileManager defaultManager] attributesOfItemAtPath:path error:error];
}

+ (NSDictionary *)attributesOfFileSystemForPath:(NSString *)path error:(NSError **)error NS_AVAILABLE(10_5, 2_0);{

    return [[NSFileManager defaultManager] attributesOfFileSystemForPath:path error:error];
}

+ (NSArray *)foldersOfDirectoryAtPath:(NSString *)path error:(NSError **)error NS_AVAILABLE(10_5, 2_0);{

    return [self foldersOfDirectoryAtPath:path notIncludeFolderName:nil error:error];
}

+ (NSArray *)filesOfDirectoryAtPath:(NSString *)path error:(NSError **)error NS_AVAILABLE(10_5, 2_0);{

    return [self filesOfDirectoryAtPath:path notIncludeFileName:nil error:error];
}

+ (NSArray *)foldersOfDirectoryAtPath:(NSString *)path notIncludeFolderName:(NSString*)notIncludeFolderName error:(NSError **)error NS_AVAILABLE(10_5, 2_0);{

    NSArray *contentNames = [self contentsOfDirectoryAtPath:path error:error];
    NSMutableArray *folders = [NSMutableArray array];
    for(NSString *contentName in contentNames){
        BOOL isDirectory = NO;
        if( [self fileExistsAtPath:[path stringByAppendingPathComponent:contentName] isDirectory:&isDirectory] && isDirectory && ![contentName isEqualToString:notIncludeFolderName]){

            [folders addObject:contentName];
        }
    }
    return folders;
}

+ (NSArray *)filesOfDirectoryAtPath:(NSString *)path notIncludeFileName:(NSString*)notIncludeFileName error:(NSError **)error NS_AVAILABLE(10_5, 2_0);{

    NSArray *contentNames = [self contentsOfDirectoryAtPath:path error:error];
    NSMutableArray *fileNames = [NSMutableArray array];
    for(NSString *contentName in contentNames){
        BOOL isDirectory = NO;
        if( [self fileExistsAtPath:[path stringByAppendingPathComponent:contentName] isDirectory:&isDirectory] && !isDirectory && ![contentName isEqualToString:notIncludeFileName]){
            [fileNames addObject:contentName];
        }
    }
    return fileNames;
}


@end

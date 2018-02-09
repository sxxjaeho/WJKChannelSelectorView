//
//  WJKSubclassificationSegmentView.h
//  iOSwujike
//
//  Created by Zeaho on 2017/8/1.
//  Copyright © 2017年 xhb_iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

// view
#import "TYTabPagerBar.h"

@protocol WJKSubclassificationSegmentViewDelegate <NSObject>

@required

@optional
- (void)subclassificationSegment:(TYTabPagerBar *)subclassificationSegment didSelectAtIndex:(NSInteger)selectedSegmentIndex;

@end

@interface WJKSubclassificationSegmentView : UIView <TYTabPagerBarDataSource,TYTabPagerBarDelegate>

@property (nonatomic, weak) id <WJKSubclassificationSegmentViewDelegate>delegate;

@property (nonatomic, strong, readonly) TYTabPagerBar *subclassificationSegment;

@property (nonatomic, strong) NSArray *subclassificationDataSource;

@end

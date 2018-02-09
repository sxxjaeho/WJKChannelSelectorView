//
//  WJKChannelSelectorView.h
//  iOSwujike
//
//  Created by Zeaho on 2018/1/31.
//  Copyright © 2018年 xhb_iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

// view
#import "WJKSubclassificationSegmentView.h"

typedef NS_ENUM(NSUInteger, WJKChannelSortType) {
    WJKChannelSortTypeHot = 0,
    WJKChannelSortTypeNew,
};

@interface WJKChannelModel : NSObject

@property (nonatomic, copy) NSString *objectId;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) UIColor *image;

@end


@class WJKChannelSelectorView;

@protocol WJKChannelSelectorViewDelegate <NSObject>

- (NSUInteger)numberOfItemsInSelector:(WJKChannelSelectorView *)selector;

- (UIView *)containerViewForExpendInSelector:(WJKChannelSelectorView *)selector;

@optional
- (void)classificationPagerBar:(TYTabPagerBar *)classificationPagerBar didSelectAtIndex:(NSInteger)selectedSegmentIndex;

- (void)channelSelectorView:(WJKChannelSelectorView *)channelSelectorView didClickedSearchButton:(UIButton *)searchButton;

- (void)channelSelectorView:(WJKChannelSelectorView *)channelSelectorView didChangeSortType:(WJKChannelSortType)sortType;

- (NSString *)channelSelectorView:(WJKChannelSelectorView *)channelSelectorView titleAtIndex:(NSUInteger)index;

- (NSString *)channelSelectorView:(WJKChannelSelectorView *)channelSelectorView coverAtIndex:(NSUInteger)index;

- (void)channelSelectorView:(WJKChannelSelectorView *)channelSelectorView didSelectAtIndex:(NSUInteger)index;

@end

@interface WJKChannelSelectorView : UIView

@property (nonatomic, weak) id<WJKChannelSelectorViewDelegate> delegate;

@property (nonatomic, strong, readonly) WJKSubclassificationSegmentView *subclassificationSegmentView;

@property (nonatomic, assign) WJKChannelSortType sortType;

/** 判断是否展开频道选择页 */
@property (nonatomic, assign) BOOL isExpand;

@property (nonatomic, copy) NSString *channelId;

@property (nonatomic, assign) NSUInteger selectedIndex;

@end

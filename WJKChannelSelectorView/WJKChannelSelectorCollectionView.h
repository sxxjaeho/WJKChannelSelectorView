//
//  WJKChannelSelectorCollectionView.h
//  iOSwujike
//
//  Created by Zeaho on 2018/1/31.
//  Copyright © 2018年 xhb_iOS. All rights reserved.
//


#import <UIKit/UIKit.h>

@class WJKChannelSelectorCollectionView;

@protocol WJKChannelSelectorCollectionViewDataSource <NSObject>

@required
- (NSUInteger)numberOfItemsInSelectorView:(WJKChannelSelectorCollectionView *)selectorView;
- (void)selectorView:(WJKChannelSelectorCollectionView *)selectorView configurateCellAtIndex:(NSUInteger)index cell:(UICollectionViewCell *)cell;

@end

@protocol WJKChannelSelectorCollectionViewDelegate <NSObject>
@optional

- (void)selectorView:(WJKChannelSelectorCollectionView *)selectorView didSelectRowAtIndex:(NSUInteger)index;
- (void)selectorView:(WJKChannelSelectorCollectionView *)selectorView didDeselectRowAtIndex:(NSUInteger)index;
- (void)didCancelInSelectorView:(WJKChannelSelectorCollectionView *)selectorView;

@end

@interface WJKChannelSelectorCollectionView : UIView

@property (nonatomic, assign) CGSize expendItemSize;
@property (nonatomic, assign, readonly) NSUInteger selectedIndex;
@property (nonatomic, weak) id<WJKChannelSelectorCollectionViewDelegate> delegate;
@property (nonatomic, weak) id<WJKChannelSelectorCollectionViewDataSource> dataSource;

- (instancetype)initWithSelectedIndex:(NSUInteger)selectedIndex;

- (void)registerClass:(Class)cellClass forCellWithReuseIdentifier:(NSString *)identifier;

- (void)reloadData;

- (void)expend:(BOOL)expend animated:(BOOL)animated completion:(void (^)(void))completion;

@end

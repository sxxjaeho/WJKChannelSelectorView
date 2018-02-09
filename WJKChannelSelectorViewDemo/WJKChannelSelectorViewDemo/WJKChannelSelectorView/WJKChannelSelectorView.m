//
//  WJKChannelSelectorView.m
//  iOSwujike
//
//  Created by Zeaho on 2018/1/31.
//  Copyright © 2018年 xhb_iOS. All rights reserved.
//

#import "WJKChannelSelectorView.h"
#import "WJKChannelSelectorCollectionView.h"
#import "WJKChannelSelectorCollectionViewCell.h"

const CGFloat WJKSubclassificationSegmentViewHeight = 36.f;

@implementation WJKChannelModel

- (instancetype)init{
    if (self = [super init]) {
    }
    return self;
}

@end

@interface WJKChannelSelectorView () <WJKSubclassificationSegmentViewDelegate, WJKChannelSelectorCollectionViewDelegate, WJKChannelSelectorCollectionViewDataSource>

@property (nonatomic, strong) UIImageView *backgroundImageView;

@property (nonatomic, strong) UIButton *searchButton;

@property (nonatomic, strong) UIView *channelSelectorView;

@property (nonatomic, strong) UIImageView *channelImageView;

@property (nonatomic, strong) UIImageView *channelArrowImageView;

@property (nonatomic, strong) UIView *sortSelectorView;

@property (nonatomic, strong) UILabel *sortLabel;

@property (nonatomic, strong) UIImageView *sortArrowImageView;

@property (nonatomic, strong) WJKChannelSelectorCollectionView *channelSelectorCollectionView;

@property (nonatomic, strong) WJKSubclassificationSegmentView *subclassificationSegmentView;

@end

@implementation WJKChannelSelectorView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self _createSubviews];
        [self _configurateSubviewsDefault];
        [self _installConstraints];
    }
    return self;
}

- (void)_createSubviews {
    
    self.backgroundImageView = [UIImageView emptyFrameView];
    [self addSubview:[self backgroundImageView]];
    
    self.searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [[self backgroundImageView] addSubview:[self searchButton]];
    
    self.channelSelectorView = [UIView emptyFrameView];
    [[self backgroundImageView] addSubview:[self channelSelectorView]];
    
    self.channelImageView = [UIImageView emptyFrameView];
    [[self channelSelectorView] addSubview:[self channelImageView]];
    
    self.channelArrowImageView = [UIImageView emptyFrameView];
    [[self channelSelectorView] addSubview:[self channelArrowImageView]];
    
    self.sortSelectorView = [UIView emptyFrameView];
    [[self backgroundImageView] addSubview:[self sortSelectorView]];
    
    self.sortLabel = [UILabel emptyFrameView];
    [[self sortSelectorView] addSubview:[self sortLabel]];
    
    self.sortArrowImageView = [UIImageView emptyFrameView];
    [[self sortSelectorView] addSubview:[self sortArrowImageView]];
    
    self.subclassificationSegmentView = [WJKSubclassificationSegmentView emptyFrameView];
    [[self backgroundImageView] addSubview:[self subclassificationSegmentView]];
}

- (void)_configurateSubviewsDefault {
    
    self.backgroundImageView.image = [UIImage imageWithColor:[UIColor redColor]];
    self.backgroundImageView.userInteractionEnabled = YES;
    
    [[self searchButton] setBackgroundImage:[UIImage imageNamed:@"selector_icon_search"] forState:UIControlStateNormal];
    [[self searchButton] addTarget:self action:@selector(didClickSearchButton:) forControlEvents:UIControlEventTouchUpInside];
    
    UITapGestureRecognizer *tapChannelSelectorViewGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickedChannelSelectorView:)];
    [[self channelSelectorView] addGestureRecognizer:tapChannelSelectorViewGesture];
    
    self.channelImageView.layer.masksToBounds = YES;
    self.channelImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    self.channelArrowImageView.image = [UIImage imageNamed:@"selector_icon_pulldown"];
    
    UITapGestureRecognizer *tapSortSelectorViewGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickedSortSelectorView:)];
    [[self sortSelectorView] addGestureRecognizer:tapSortSelectorViewGesture];
    
    self.sortLabel.text = @"最热";
    self.sortLabel.textAlignment = NSTextAlignmentRight;
    self.sortLabel.textColor = [UIColor whiteColor];
    self.sortLabel.font = [UIFont systemFontOfSize:15];
    self.sortArrowImageView.image = [UIImage imageNamed:@"selector_icon_change"];
 
    self.subclassificationSegmentView.delegate = self;
    self.subclassificationSegmentView.subclassificationDataSource = [NSMutableArray arrayWithObjects:@"表演", @"文化", @"教学", @"比赛", nil];
}

- (void)_installConstraints {
    
    [[self backgroundImageView] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self).mas_offset(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    [[self searchButton] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.backgroundImageView).mas_offset(34);
        make.left.mas_equalTo(self.backgroundImageView).mas_offset(15);
        make.size.mas_equalTo(CGSizeMake(17, 17));
    }];
    
    [[self channelSelectorView] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.backgroundImageView).mas_offset(-134);
        make.top.mas_equalTo(self.searchButton).mas_offset(-2);
        make.height.mas_equalTo(30);
        make.width.mas_lessThanOrEqualTo(self.backgroundImageView);
    }];
    
    [[self channelArrowImageView] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.channelSelectorView).mas_offset(4);
        make.right.mas_equalTo(self.channelSelectorView);
        make.size.mas_equalTo(CGSizeMake(17, 11));
    }];
    
    [[self channelImageView] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.mas_equalTo(self.channelSelectorView).mas_offset(UIEdgeInsetsMake(0, 0, 0, 0));
        make.right.mas_equalTo(self.channelArrowImageView.mas_left).mas_offset(-8);
    }];
    
    [[self sortSelectorView] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.backgroundImageView);
        make.top.mas_equalTo(self.searchButton).mas_offset(4);
        make.size.mas_equalTo(CGSizeMake(65, 18));
    }];
    
    [[self sortArrowImageView] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.sortSelectorView).mas_offset(2);
        make.right.mas_equalTo(self.sortSelectorView).mas_offset(-15);
        make.size.mas_equalTo(CGSizeMake(10, 12));
    }];
    
    [[self sortLabel] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.sortSelectorView);
        make.right.mas_equalTo(self.sortArrowImageView.mas_left).mas_offset(-4);
        make.left.mas_equalTo(self.sortSelectorView);
        make.height.mas_equalTo(14);
    }];
    
    [[self subclassificationSegmentView] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(self.backgroundImageView).mas_offset(UIEdgeInsetsMake(0, 0, 5, 0));
        
        make.height.mas_equalTo(WJKSubclassificationSegmentViewHeight);
    }];
}

- (void)_expandSelectorCollectionView {
    
    [UIView animateWithDuration:.3f
                     animations:^{
                         self.channelArrowImageView.transform = CGAffineTransformRotate(self.channelArrowImageView.transform, M_PI);
                     }];
    
    UIView *containerView = [self containerView];
    CGRect rectInContainerView = [self convertRect:[self bounds] toView:containerView];
    self.channelSelectorCollectionView = [self newSegmentCollectionSelectorView];
    self.channelSelectorCollectionView.frame = CGRectMakePWH(rectInContainerView.origin, CGRectGetWidth(rectInContainerView), CGRectGetHeight([containerView bounds]) - CGRectGetMinY(rectInContainerView));
    
    [containerView addSubview:[self channelSelectorCollectionView]];
    [[self channelSelectorCollectionView] reloadData];
    
    self.userInteractionEnabled = NO;
    [UIView animateWithDuration:.5f animations:^{
        self.userInteractionEnabled = YES;
    } completion:^(BOOL finished) {
        self.channelSelectorCollectionView.alpha = 1.f;
        [[self channelSelectorCollectionView] expend:YES animated:YES completion:^{
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
        }];
    }];
    
}

- (void)_narrowSelectorCollectionView {
    
    // 如果是第一次启动应用则展开频道选择页面
    if (![[NSUserDefaults standardUserDefaults] boolForKey:WJKFirstShowChannelSelectorViewUserDefaultKey]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:WJKFirstShowChannelSelectorViewUserDefaultKey];
    }
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    [UIView animateWithDuration:.3f
                     animations:^{
                         self.channelArrowImageView.transform = CGAffineTransformRotate(self.channelArrowImageView.transform, M_PI);
                     }];
    
    self.userInteractionEnabled = NO;
    [[self channelSelectorCollectionView] expend:NO animated:YES completion:^{
        [UIView animateWithDuration:0.1 animations:^{
            self.userInteractionEnabled = YES;
        } completion:^(BOOL finished) {
            self.channelSelectorCollectionView.alpha = 0.f;
            [[self channelSelectorCollectionView] removeFromSuperview];
        }];
    }];
}

- (void)_updateDisplaySubviews {
    self.channelImageView.image = self.channelId ? [UIImage imageNamed:[NSString stringWithFormat:@"channel_img_name_%@", [self channelId]]] : [UIImage imageNamed:@"channel_img_name_5"];
    self.backgroundImageView.image = self.channelId ? [UIImage imageNamed:[NSString stringWithFormat:@"channle_img_background_%@", [self channelId]]] : [UIImage imageNamed:@"channle_img_background_5"];
}

#pragma mark - action

- (void)didClickSearchButton:(UIButton *)sender {
    if ([[self delegate] respondsToSelector:@selector(channelSelectorView:didClickedSearchButton:)]) {
        [[self delegate] channelSelectorView:self didClickedSearchButton:sender];
    }
}

- (void)didClickedChannelSelectorView:(UITapGestureRecognizer *)sender {
    self.isExpand = !self.isExpand;
}

- (void)didClickedSortSelectorView:(UITapGestureRecognizer *)sender {
    
    if (self.sortType == WJKChannelSortTypeHot) {
        self.sortType = WJKChannelSortTypeNew;
        self.sortLabel.text = @"最新";
    } else {
        self.sortType = WJKChannelSortTypeHot;
        self.sortLabel.text = @"最热";
    }
    
    if ([[self delegate] respondsToSelector:@selector(channelSelectorView:didChangeSortType:)]) {
        [[self delegate] channelSelectorView:self didChangeSortType:[self sortType]];
    }
}

#pragma mark - accessor

- (void)setIsExpand:(BOOL)isExpand {
    _isExpand = isExpand;
    if (isExpand) {
        [self _expandSelectorCollectionView];
    } else {
        [self _narrowSelectorCollectionView];
    }
}

- (void)setSortType:(WJKChannelSortType)sortType {
    _sortType = sortType;
}

- (void)setChannelId:(NSString *)channelId {
    if (_channelId != channelId) {
        _channelId = channelId;
    }
    [self _updateDisplaySubviews];
}

#pragma mark - delegate operator

- (NSUInteger)numberOfItems {
    if ([[self delegate] respondsToSelector:@selector(numberOfItemsInSelector:)]) {
        return [[self delegate] numberOfItemsInSelector:self];
    }
    return 0;
}

- (UIView *)containerView {
    if ([[self delegate] respondsToSelector:@selector(containerViewForExpendInSelector:)]) {
        return [[self delegate] containerViewForExpendInSelector:self];
    }
    return nil;
}

- (NSString *)titleAtIndex:(NSUInteger)index {
    if ([[self delegate] respondsToSelector:@selector(channelSelectorView:titleAtIndex:)]) {
        return [[self delegate] channelSelectorView:self titleAtIndex:index];
    }
    return nil;
}

- (NSString *)coverAtIndex:(NSUInteger)index {
    if ([[self delegate] respondsToSelector:@selector(channelSelectorView:coverAtIndex:)]) {
        return [[self delegate] channelSelectorView:self coverAtIndex:index];
    }
    return nil;
}

- (void)didSelectAtIndex:(NSUInteger)index {
    self.selectedIndex = index;
    if ([[self delegate] respondsToSelector:@selector(channelSelectorView:didSelectAtIndex:)]) {
        [[self delegate] channelSelectorView:self didSelectAtIndex:index];
    }
}

- (WJKChannelSelectorCollectionView *)newSegmentCollectionSelectorView {
    NSInteger column = 2;
    CGFloat itemWidth = (CGRectGetWidth([self bounds]) - 30 - (column - 1) * 23 ) / column;
    
    WJKChannelSelectorCollectionView *channelSelectorCollectionView = [[WJKChannelSelectorCollectionView alloc] initWithSelectedIndex:[self selectedIndex]];
    channelSelectorCollectionView.dataSource = self;
    channelSelectorCollectionView.delegate = self;
    channelSelectorCollectionView.alpha = 0.f;
    channelSelectorCollectionView.expendItemSize = CGSizeMake(itemWidth, 80);
    [channelSelectorCollectionView registerClass:[WJKChannelSelectorCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([WJKChannelSelectorCollectionViewCell class])];
    
    return channelSelectorCollectionView;
}

#pragma mark - WJKSubclassificationSegmentViewDelegate

- (void)subclassificationSegment:(TYTabPagerBar *)subclassificationSegment didSelectAtIndex:(NSInteger)selectedSegmentIndex {
    if ([[self delegate] respondsToSelector:@selector(classificationPagerBar:didSelectAtIndex:)]) {
        [[self delegate] classificationPagerBar:subclassificationSegment didSelectAtIndex:selectedSegmentIndex];
    }
}

#pragma WJKChannelSelectorCollectionViewDelegate, WJKChannelSelectorCollectionViewDataSource

- (NSUInteger)numberOfItemsInSelectorView:(WJKChannelSelectorCollectionView *)selectorView {
    return [self numberOfItems];
}

- (void)selectorView:(WJKChannelSelectorCollectionView *)selectorView configurateCellAtIndex:(NSUInteger)index cell:(WJKChannelSelectorCollectionViewCell *)cell {
    cell.title = [self titleAtIndex:index];
    cell.coverUrl = [self coverAtIndex:index];
}

- (void)selectorView:(WJKChannelSelectorCollectionView *)selectorView didSelectRowAtIndex:(NSUInteger)index {
    // 更多频道,敬请期待
    if (([self numberOfItems] == 4 && index == 3) || ([self numberOfItems] == 1 && index == 0)) {
        return;
    }
    self.isExpand = NO;
    [self didSelectAtIndex:index];
}

- (void)didCancelInSelectorView:(WJKChannelSelectorCollectionView *)selectorView {
    self.isExpand = NO;
}

@end

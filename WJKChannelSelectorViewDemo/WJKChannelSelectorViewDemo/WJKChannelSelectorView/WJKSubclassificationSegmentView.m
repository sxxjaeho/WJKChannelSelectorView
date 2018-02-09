//
//  WJKSubclassificationSegmentView.m
//  iOSwujike
//
//  Created by Zeaho on 2017/8/1.
//  Copyright © 2017年 xhb_iOS. All rights reserved.
//

#import "WJKSubclassificationSegmentView.h"

@interface WJKSubclassificationSegmentView ()

@property (nonatomic, strong) TYTabPagerBar *subclassificationSegment;

@end

@implementation WJKSubclassificationSegmentView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self _createSubviews];
        [self _configurateSubviewsDefault];
        [self _installConstraint];
    }
    return self;
}

#pragma mark - private

- (void)_createSubviews {
    
    self.subclassificationSegment = [[TYTabPagerBar alloc] init];
    [self addSubview:[self subclassificationSegment]];
}

- (void)_configurateSubviewsDefault {
    
    self.subclassificationSegment.backgroundColor = [UIColor clearColor];
    self.subclassificationSegment.layout.barStyle = TYPagerBarStyleProgressView;
    self.subclassificationSegment.layout.normalTextColor = [UIColor colorWithWhite:1 alpha:0.7];
    self.subclassificationSegment.layout.normalTextFont = [UIFont systemFontOfSize:14];
    self.subclassificationSegment.layout.selectedTextColor = [UIColor whiteColor];
    self.subclassificationSegment.layout.selectedTextFont = [UIFont systemFontOfSize:14];
    self.subclassificationSegment.layout.progressWidth = 15;
    self.subclassificationSegment.layout.progressHeight = 3;
    self.subclassificationSegment.layout.progressRadius = 1;
    self.subclassificationSegment.layout.progressVerEdging = 0;
    self.subclassificationSegment.layout.progressColor = [UIColor whiteColor];
    self.subclassificationSegment.layout.cellWidth = kScreenWidth / 4;
    self.subclassificationSegment.layout.cellEdging = 0;
    self.subclassificationSegment.layout.cellSpacing = 0;
    self.subclassificationSegment.dataSource = self;
    self.subclassificationSegment.delegate = self;
    [[self subclassificationSegment] registerClass:[TYTabPagerBarCell class] forCellWithReuseIdentifier:[TYTabPagerBarCell cellIdentifier]];
}

- (void)_installConstraint {
    [[self subclassificationSegment] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
}

#pragma mark - TYTabPagerBarDataSource

- (NSInteger)numberOfItemsInPagerTabBar {
    return [[self subclassificationDataSource] count];
}

- (UICollectionViewCell<TYTabPagerBarCellProtocol> *)pagerTabBar:(TYTabPagerBar *)pagerTabBar cellForItemAtIndex:(NSInteger)index {
    UICollectionViewCell<TYTabPagerBarCellProtocol> *cell = [pagerTabBar dequeueReusableCellWithReuseIdentifier:[TYTabPagerBarCell cellIdentifier] forIndex:index];
    cell.titleLabel.text = [self subclassificationDataSource][index];
    return cell;
}

#pragma mark - TYTabPagerBarDelegate

- (void)pagerTabBar:(TYTabPagerBar *)pagerTabBar didSelectItemAtIndex:(NSInteger)index {
    
    if ([[self delegate] respondsToSelector:@selector(subclassificationSegment:didSelectAtIndex:)]) {
        [[self delegate] subclassificationSegment:pagerTabBar didSelectAtIndex:index];
    }
}

#pragma mark - accessor

- (void)setSubclassificationDataSource:(NSArray *)subclassificationDataSource {
    
    if (_subclassificationDataSource != subclassificationDataSource) {
        _subclassificationDataSource = subclassificationDataSource;
    }
    [[self subclassificationSegment] reloadData];
}

@end

//
//  WJKChannelSelectorCollectionView.m
//  iOSwujike
//
//  Created by Zeaho on 2018/1/31.
//  Copyright © 2018年 xhb_iOS. All rights reserved.
//

#import "WJKChannelSelectorCollectionView.h"

@interface WJKChannelSelectorCollectionView ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, assign) NSUInteger selectedIndex;
@property (nonatomic, strong) NSMutableDictionary<NSString *, Class> *reusableCellClasses;
@property (nonatomic, assign) NSInteger numberOfItems;

@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subtitleLabel;
@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, assign, readonly) CGFloat collectionViewHeight;
@property (nonatomic, strong, readonly) UICollectionViewLayout *collectionViewLayout;

@end

@implementation WJKChannelSelectorCollectionView

- (instancetype)initWithSelectedIndex:(NSUInteger)selectedIndex{
    if (self = [super init]) {
        
        self.selectedIndex = selectedIndex;
        
        [self _creatSubviews];
        [self _configurateSubviewDefault];
        [self _installConstraints];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.selectedIndex = 0;
        
        [self _creatSubviews];
    }
    return self;
}

#pragma mark - accessor

- (UICollectionViewLayout *)collectionViewLayout {
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    // 默认itemSize为(0,0)会报警告
    layout.itemSize = self.expendItemSize.height > 0 ? self.expendItemSize : CGSizeMake(8, 8);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumLineSpacing = 22;
    layout.minimumInteritemSpacing = 8;
    return layout;
}

- (CGFloat)collectionViewHeight {
    
    NSInteger columns = 2;
    NSInteger rows = self.numberOfItems / columns + (self.numberOfItems % columns != 0);
    
    return rows * self.expendItemSize.height + (rows - 1) * 22;
}

#pragma mark - private

- (void)_creatSubviews {
    self.reusableCellClasses = [NSMutableDictionary dictionary];
    
    self.backgroundView = [[UIView alloc] init];
    self.contentView = [[UIView alloc] init];
    self.closeButton = [[UIButton alloc] init];
    self.titleLabel = [[UILabel alloc] init];
    self.subtitleLabel = [[UILabel alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[self collectionViewLayout]];

    [self addSubview:[self backgroundView]];
    [self addSubview:[self contentView]];
    [self addSubview:[self closeButton]];
    [self addSubview:[self titleLabel]];
    [self addSubview:[self subtitleLabel]];
    [self addSubview:[self collectionView]];
}

- (void)_configurateSubviewDefault {
    
    self.layer.masksToBounds = YES;
    
    self.backgroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    [[self backgroundView] addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickBackgroundView:)]];
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.contentView.layer.masksToBounds = YES;
    
    self.closeButton.hotSpotInsets = UIEdgeInsetsMake(-10, -10, -10, -10);
    
    [[self closeButton] setImage:[UIImage imageNamed:@"channel_btn_close"] forState:UIControlStateNormal];
    [[self closeButton] addTarget:self action:@selector(didClickArrowButton:) forControlEvents:UIControlEventTouchUpInside];
    
    self.titleLabel.text = @"频道选择";
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont systemFontOfSize:18];
    self.titleLabel.textColor = [UIColor blackColor];
    
    self.subtitleLabel.text = @"请选择一个你喜欢的舞种";
    self.subtitleLabel.textAlignment = NSTextAlignmentCenter;
    self.subtitleLabel.font = [UIFont systemFontOfSize:13];
    self.subtitleLabel.textColor = [UIColor grayColor];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor clearColor];
    
    [[self collectionView] registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class])];
}

- (void)_installConstraints {
    
    [[self backgroundView] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [[self closeButton] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.contentView).mas_offset(38);
        make.size.mas_equalTo(CGSizeMake(29, 29));
    }];
    
    [[self titleLabel] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.closeButton.mas_bottom).mas_offset(20);
        make.leading.trailing.mas_equalTo(self.contentView);
        make.height.mas_equalTo(17);
    }];
    
    [[self subtitleLabel] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_offset(6);
        make.leading.trailing.mas_equalTo(self.contentView);
        make.height.mas_equalTo(13);
    }];
    
    [[self collectionView] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.subtitleLabel.mas_bottom).mas_offset(20);
        make.left.mas_equalTo(self.contentView).mas_offset(16);
        make.right.mas_equalTo(self.contentView).mas_offset(-16);
        make.bottom.mas_equalTo(self.contentView).mas_offset(-48);
    }];
    
    [self _updateHiddenContentConstraints];
}

- (void)_updateDisplayContentConstraints {
    CGFloat contentHeight = [self collectionViewHeight] + 38 + 29 + 20 + 17 + 6 + 13 + 20 + 48;
    
    [[self contentView] mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(self);
        make.height.mas_equalTo(contentHeight);
    }];
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, kScreenWidth, contentHeight) byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = CGRectMake(0, 0, kScreenWidth, contentHeight);
    maskLayer.path = maskPath.CGPath;
    self.contentView.layer.mask = maskLayer;
}

- (void)_updateHiddenContentConstraints {
    CGFloat contentHeight = [self collectionViewHeight] + 38 + 29 + 20 + 17 + 6 + 13 + 45 + 48;
    
    [[self contentView] mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.top.mas_equalTo(self).mas_offset(-contentHeight);
    }];
}

- (void)_cancel {
    if ([self delegate] && [[self delegate] respondsToSelector:@selector(didCancelInSelectorView:)]) {
        [[self delegate] didCancelInSelectorView:self];
    }
}

#pragma mark - UICollectionViewDelegate and UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.numberOfItems;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[[[self reusableCellClasses] allKeys] firstObject] forIndexPath:indexPath];
    [[self dataSource] selectorView:self configurateCellAtIndex:[indexPath row] cell:cell];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self delegate] && [[self delegate] respondsToSelector:@selector(selectorView:didSelectRowAtIndex:)]) {
        [[self delegate] selectorView:self didSelectRowAtIndex:[indexPath row]];
    }
    
    self.selectedIndex = [indexPath row];
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self delegate] && [[self delegate] respondsToSelector:@selector(selectorView:didDeselectRowAtIndex:)]) {
        [[self delegate] selectorView:self didDeselectRowAtIndex:[indexPath row]];
    }
}

#pragma mark public

- (void)reloadData {
    if (self.dataSource == nil) {
        return;
    }
    self.numberOfItems = [self.dataSource numberOfItemsInSelectorView:self];
    self.collectionView.collectionViewLayout = [self collectionViewLayout];
    
    [[self collectionView] reloadData];
    if ([self selectedIndex] < [self numberOfItems]) {
        [[self collectionView] selectItemAtIndexPath:[NSIndexPath indexPathForRow:[self selectedIndex] inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionNone];
    }
}

- (void)registerClass:(Class)cellClass forCellWithReuseIdentifier:(NSString *)identifier {
    self.reusableCellClasses[identifier] = cellClass;
    
    [[self collectionView] registerClass:cellClass forCellWithReuseIdentifier:identifier];
}

- (void)expend:(BOOL)expend animated:(BOOL)animated completion:(void (^)(void))completion {
    if (expend) {
        [self _updateHiddenContentConstraints];
    }
    [self layoutIfNeeded];
    void (^transform)(void) = ^{
        if (expend) {
            [self _updateDisplayContentConstraints];
        } else {
            [self _updateHiddenContentConstraints];
        }
        [self layoutIfNeeded];
    };
    void (^transformCompletion)(BOOL finished) = ^(BOOL finished){
        if (completion) {
            completion();
        }
    };
    if (animated) {
        [UIView animateWithDuration:0.15 animations:transform completion:transformCompletion];
    } else {
        transform();
        transformCompletion(YES);
    }
}

#pragma mark action

- (IBAction)didClickBackgroundView:(UITapGestureRecognizer *)tapGestureRecognizer {
    [self _cancel];
}

- (IBAction)didClickArrowButton:(id)sender {
    [self _cancel];
}

@end

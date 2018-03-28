//
//  WJKChannelSelectorCollectionViewCell.m
//  iOSwujike
//
//  Created by Zeaho on 2018/1/31.
//  Copyright © 2018年 xhb_iOS. All rights reserved.
//

#import "WJKChannelSelectorCollectionViewCell.h"

@interface WJKChannelSelectorCollectionViewCell ()

//@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIImageView *coverImageView;

@end


@implementation WJKChannelSelectorCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self _createSubviews];
        [self _configurateSubviewsDefault];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
//    self.titleLabel.frame = [self bounds];
    
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    
    self.coverImageView.frame = [self bounds];
    
    [CATransaction commit];
}

#pragma mark - accessor

//- (void)setTitle:(NSString *)title {
//    if (_title != title) {
//        _title = title;
//    }
//    self.titleLabel.text = title;
//}

- (void)setCoverUrl:(NSString *)coverUrl {
    if (_coverUrl != coverUrl) {
        _coverUrl = coverUrl;
    }
//    [[self coverImageView] sd_setImageWithURL:[NSURL URLWithString:_coverUrl] placeholderImage:[UIImage imageNamed:@"video_img_placeholder"]];
    self.coverImageView.image = [UIImage imageNamed:coverUrl];
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    
//    self.titleLabel.font = selected ? [UIFont boldSystemFontOfSize:15] : [UIFont systemFontOfSize:15];
//    self.titleLabel.textColor = self.isSelected ? [UIColor green1Color] : [UIColor white1Color];
}

#pragma mark - private

- (void)_createSubviews {
    
//    self.titleLabel = [UILabel emptyFrameView];
//    [[self contentView] addSubview:[self titleLabel]];
    
    self.coverImageView = [UIImageView emptyFrameView];
    [[self contentView] addSubview:[self coverImageView]];
}

- (void)_configurateSubviewsDefault {
    
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    
//    self.titleLabel.font = [UIFont systemFontOfSize:15];
//    self.titleLabel.adjustsFontSizeToFitWidth = YES;
//    self.titleLabel.minimumScaleFactor = 0.5;
//    self.titleLabel.textColor = [UIColor white1Color];
//    self.titleLabel.textAlignment = NSTextAlignmentCenter;
//    self.titleLabel.backgroundColor = [UIColor white7Color];
//    self.titleLabel.layer.cornerRadius = 4;
//    self.titleLabel.layer.masksToBounds = YES;
    self.coverImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.coverImageView.layer.cornerRadius = 10;
    self.coverImageView.layer.masksToBounds = YES;
}

@end

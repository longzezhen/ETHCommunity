//
//  ETHMemberInfoButton.m
//  ETHCommunity
//
//  Created by 龙泽桢 on 2019/6/10.
//  Copyright © 2019 tools. All rights reserved.
//

#import "ETHMemberInfoButton.h"

@implementation ETHMemberInfoButton

-(instancetype)init
{
    if (self = [super init]) {
        self.leftLabel.hidden = NO;
        self.rightLabel.hidden = NO;
        self.rightImageView.hidden = NO;
        self.bottomLineView.hidden = NO;
    }
    return self;
}

#pragma mark - get
-(UILabel *)leftLabel
{
    if (!_leftLabel) {
        _leftLabel = [UILabel new];
        _leftLabel.textColor = ColorFromRGB(0xFFFFFF);
        _leftLabel.font = KFont(15);
        [self addSubview:_leftLabel];
        [_leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.left.mas_equalTo(Auto_Width(16));
        }];
    }
    return _leftLabel;
}

-(UILabel *)rightLabel
{
    if (!_rightLabel) {
        _rightLabel = [UILabel new];
        _rightLabel.textColor = ColorFromRGB(0xFFFFFF);
        _rightLabel.font = KFont(15);
        [self addSubview:_rightLabel];
        [_rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.right.mas_equalTo(Auto_Width(-19));
        }];
    }
    return _rightLabel;
}

-(UIImageView *)rightImageView
{
    if (!_rightImageView) {
        _rightImageView = [[UIImageView alloc] init];
        _rightImageView.image = ImageNamed(@"icon_ecology_select");
        [self addSubview:_rightImageView];
        [_rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.right.mas_equalTo(Auto_Width(-19));
            make.size.mas_equalTo(CGSizeMake(Auto_Width(24), Auto_Width(24)));
        }];
    }
    return _rightImageView;
}

-(UIView *)bottomLineView
{
    if (!_bottomLineView) {
        _bottomLineView = [UIView new];
        _bottomLineView.backgroundColor = ColorFromRGBA(0xFFFFFF, 0.1);
        [self addSubview:_bottomLineView];
        [_bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Auto_Width(16));
            make.right.mas_equalTo(Auto_Width(-19));
            make.bottom.mas_equalTo(0);
            make.height.mas_equalTo(Auto_Width(2));
        }];
    }
    return _bottomLineView;
}

@end

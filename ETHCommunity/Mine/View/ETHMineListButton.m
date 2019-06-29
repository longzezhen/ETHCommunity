//
//  ETHMineListButton.m
//  ETHCommunity
//
//  Created by 龙泽桢 on 2019/6/5.
//  Copyright © 2019 tools. All rights reserved.
//

#import "ETHMineListButton.h"

@implementation ETHMineListButton

-(instancetype)init{
    if (self = [super init]) {
        self.leftImageView.hidden = NO;
        self.middleLabel.hidden = NO;
        self.arrowImageView.hidden = NO;
    }
    self.backgroundColor = ColorFromRGBA(0xFFFFFF, 0.0549);
    return self;
}

-(UIImageView *)leftImageView
{
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc] init];
        [self addSubview:_leftImageView];
        [_leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.left.mas_equalTo(Auto_Width(16));
            make.size.mas_equalTo(CGSizeMake(Auto_Width(17), Auto_Width(17)));
        }];
    }
    return _leftImageView;
}

-(UILabel *)middleLabel
{
    if (!_middleLabel) {
        _middleLabel = [UILabel new];
        _middleLabel.textColor = ColorFromRGB(0xFFFFFF);
        _middleLabel.font = KFont(14);
        [self addSubview:_middleLabel];
        [_middleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.left.mas_equalTo(self.leftImageView.mas_right).mas_equalTo(Auto_Width(15));
        }];
    }
    return _middleLabel;
}

-(UIImageView *)arrowImageView
{
    if (!_arrowImageView) {
        _arrowImageView = [[UIImageView alloc] initWithImage:ImageNamed(@"icon_into_arrow")];
        [self addSubview:_arrowImageView];
        [_arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.right.mas_equalTo(Auto_Width(-19));
            make.size.mas_equalTo(CGSizeMake(Auto_Width(6), Auto_Width(12)));
        }];
    }
    return _arrowImageView;
}

@end

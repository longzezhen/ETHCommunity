//
//  ETHListView.m
//  ETHCommunity
//
//  Created by 龙泽桢 on 2019/5/31.
//  Copyright © 2019 tools. All rights reserved.
//

#import "ETHListView.h"

@implementation ETHListView
-(instancetype)init
{
    if (self = [super init]) {
        self.leftLabel.hidden = NO;
        self.rightTextField.hidden = NO;
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

-(UITextField *)rightTextField
{
    if (!_rightTextField) {
        _rightTextField = [UITextField new];
        _rightTextField.textColor = ColorFromRGB(0xFFFFFF);
        _rightTextField.placeholder = @"1";
        [_rightTextField setValue:ColorFromRGB(0x909090) forKeyPath:@"_placeholderLabel.textColor"];
        [_rightTextField setValue:KFont(14) forKeyPath:@"_placeholderLabel.font"];
        _rightTextField.textAlignment = NSTextAlignmentRight;
        [self addSubview:_rightTextField];
        [_rightTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.right.mas_equalTo(Auto_Width(-16));
            make.size.mas_equalTo(CGSizeMake(Auto_Width(200), Auto_Width(50)));
        }];
    }
    return _rightTextField;
}

-(UIView *)bottomLineView
{
    if (!_bottomLineView) {
        _bottomLineView = [UIView new];
        _bottomLineView.backgroundColor = ColorFromRGBA(0xFFFFFF, 0.1);
        [self addSubview:_bottomLineView];
        [_bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Auto_Width(16));
            make.right.mas_equalTo(Auto_Width(-16));
            make.bottom.mas_equalTo(0);
            make.height.mas_equalTo(Auto_Width(1));
        }];
    }
    return _bottomLineView;
}
@end

//
//  ETHPriceListCell.m
//  ETHCommunity
//
//  Created by 龙泽桢 on 2019/6/4.
//  Copyright © 2019 tools. All rights reserved.
//

#import "ETHPriceListCell.h"

@implementation ETHPriceListCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backView.hidden = NO;
        self.leftLabel.hidden = NO;
        self.middleLabel.hidden = NO;
        self.rightLabel.hidden = NO;
        self.bottomLineView.hidden = NO;
    }
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
    return self;
}

#pragma mark - get/set
-(void)setDic:(NSDictionary *)dic
{
    self.leftLabel.text = [NSString stringWithFormat:@"%@",dic[@"symbol"]];
    self.middleLabel.text = [NSString stringWithFormat:@"%@",dic[@"lastPrice"]];
    self.rightLabel.text = [NSString stringWithFormat:@"%@",dic[@"increase"]];
    if ([dic[@"increase"] floatValue] >=0) {
        self.rightLabel.textColor = ColorFromRGB(0x59A10A);
    }else{
         self.rightLabel.textColor = ColorFromRGB(0xFF313E);
    }
}

-(UIView *)backView
{
    if (!_backView) {
        _backView = [UIView new];
        _backView.backgroundColor = ColorFromRGBA(0xFFFFFF, 0.0549);
        [self.contentView addSubview:_backView];
        [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Auto_Width(15));
            make.right.mas_equalTo(Auto_Width(-15));
            make.top.bottom.mas_equalTo(0);
        }];
    }
    return _backView;
}

-(UILabel *)leftLabel
{
    if (!_leftLabel) {
        _leftLabel = [UILabel new];
        _leftLabel.text = @"ETH";
        _leftLabel.textColor = ColorFromRGB(0xFFFFFF);
        _leftLabel.font = KFont(13);
        [self.backView addSubview:_leftLabel];
        [_leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.left.mas_equalTo(Auto_Width(16));
        }];
    }
    return _leftLabel;
}

-(UILabel *)middleLabel
{
    if (!_middleLabel) {
        _middleLabel = [UILabel new];
        _middleLabel.text = @"$188.9700";
        _middleLabel.textColor = ColorFromRGB(0xFFFFFF);
        _middleLabel.font = KFont(13);
        [self.backView addSubview:_middleLabel];
        [_middleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(0);
        }];
    }
    return _middleLabel;
}

-(UILabel *)rightLabel
{
    if (!_rightLabel) {
        _rightLabel = [UILabel new];
        _rightLabel.text = @"-0.94%";
        _rightLabel.textColor = ColorFromRGB(0xFF313E);
        _rightLabel.font = KFont(13);
        [self.backView addSubview:_rightLabel];
        [_rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.right.mas_equalTo(Auto_Width(-16));
        }];
    }
    return _rightLabel;
}

-(UIView *)bottomLineView
{
    if (!_bottomLineView) {
        _bottomLineView = [UIView new];
        _bottomLineView.backgroundColor = ColorFromRGBA(0xF4F4F4, 0.0453);
        [self.backView addSubview:_bottomLineView];
        [_bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.height.mas_equalTo(Auto_Width(2));
        }];
    }
    return _bottomLineView;
}
@end

//
//  ETHWalletListCell.m
//  ETHCommunity
//
//  Created by 龙泽桢 on 2019/6/4.
//  Copyright © 2019 tools. All rights reserved.
//

#import "ETHWalletListCell.h"

@implementation ETHWalletListCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backView.hidden = NO;
        self.iconImageView.hidden = NO;
        self.titleLabel.hidden = NO;
        self.detailButton.hidden = NO;
        self.bottomLabel.hidden = NO;
    }
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
    return self;
}

#pragma mark - get
-(UIView *)backView
{
    if (!_backView) {
        _backView = [UIView new];
        _backView.backgroundColor = ColorFromRGBA(0xFFFFFF, 0.0549);
        [self.contentView addSubview:_backView];
        [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Auto_Width(15));
            make.right.mas_equalTo(Auto_Width(-15));
            make.bottom.mas_equalTo(0);
            make.top.mas_equalTo(Auto_Width(10));
        }];
    }
    return _backView;
}

-(UIImageView *)iconImageView
{
    if (!_iconImageView) {
        _iconImageView = [UIImageView new];
        _iconImageView.image = ImageNamed(@"eth_wallet");
        LayerMakeCorner(_iconImageView, Auto_Width(20));
        [self.backView addSubview:_iconImageView];
        [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.left.mas_equalTo(Auto_Width(20));
            make.size.mas_equalTo(CGSizeMake(Auto_Width(40), Auto_Width(40)));
        }];
    }
    return _iconImageView;
}

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.text = @"ETH-Wallet";
        _titleLabel.textColor = ColorFromRGB(0xFFFFFF);
        _titleLabel.font = KFont(14);
        [self.backView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.left.mas_equalTo(self.iconImageView.mas_right).mas_equalTo(13);
        }];
    }
    return _titleLabel;
}

-(UIButton *)detailButton
{
    if (!_detailButton) {
        _detailButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_detailButton setImage:ImageNamed(@"eth_icon_more") forState:UIControlStateNormal];
        [self.backView addSubview:_detailButton];
        [_detailButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(Auto_Width(20));
            make.right.mas_equalTo(Auto_Width(-20));
            make.size.mas_equalTo(CGSizeMake(Auto_Width(24), Auto_Width(5)));
        }];
    }
    return _detailButton;
}

-(UILabel *)bottomLabel
{
    if (!_bottomLabel) {
        _bottomLabel = [UILabel new];
        _bottomLabel.text = @"0.0";
        _bottomLabel.textColor = ColorFromRGB(0xFFFFFF);
        _bottomLabel.font = KFont(16);
        [self.backView addSubview:_bottomLabel];
        [_bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(Auto_Width(-18));
            make.bottom.mas_equalTo(Auto_Width(-12));
        }];
    }
    return _bottomLabel;
}
@end

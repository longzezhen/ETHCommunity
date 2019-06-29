//
//  ETHEcologicalListCell.m
//  ETHCommunity
//
//  Created by 龙泽桢 on 2019/6/15.
//  Copyright © 2019 tools. All rights reserved.
//

#import "ETHEcologicalListCell.h"
@interface ETHEcologicalListCell()

@end

@implementation ETHEcologicalListCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backView.hidden = NO;
        self.iconImageView.hidden = NO;
        self.titleLabel.hidden = NO;
        self.subTitleLabel.hidden = NO;
        self.detailButton.hidden = NO;
    }
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
    return self;
}

#pragma mark - get/set
-(void)setDataDic:(NSDictionary *)dataDic
{
    self.iconImageView.image = ImageNamed(dataDic[@"imageName"]);
    self.titleLabel.text = dataDic[@"title"];
    self.subTitleLabel.text = dataDic[@"subTitle"];
    
}

-(UIView *)backView
{
    if (!_backView) {
        _backView = [UIView new];
        _backView.backgroundColor = ColorFromRGBA(0xFFFFFF, 0.0549);
        LayerMakeCorner(_backView, Auto_Width(4));
        [self.contentView addSubview:_backView];
        [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(Auto_Width(15));
            make.right.mas_equalTo(Auto_Width(-15));
            make.bottom.mas_equalTo(Auto_Width(-15));
        }];
    }
    return _backView;
}

-(UIImageView *)iconImageView
{
    if (!_iconImageView) {
        _iconImageView = [UIImageView new];
        LayerMakeCorner(_iconImageView, Auto_Width(43/2));
        [self.backView addSubview:_iconImageView];
        [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.left.mas_equalTo(Auto_Width(17));
            make.size.mas_equalTo(CGSizeMake(Auto_Width(43), Auto_Width(43)));
        }];
    }
    return _iconImageView;
}

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = ColorFromRGB(0xFFFFFF);
        _titleLabel.font = KFont(14);
        [self.backView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.iconImageView);
            make.left.mas_equalTo(self.iconImageView.mas_right).mas_equalTo(Auto_Width(13));
        }];
    }
    return _titleLabel;
}

-(UILabel *)subTitleLabel
{
    if (!_subTitleLabel) {
        _subTitleLabel = [UILabel new];
        _subTitleLabel.textColor = ColorFromRGB(0x9B9B9B);
        _subTitleLabel.font = KFont(12);
        [self.backView addSubview:_subTitleLabel];
        [_subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.iconImageView);
            make.left.mas_equalTo(self.iconImageView.mas_right).mas_equalTo(Auto_Width(13));
        }];
    }
    return _subTitleLabel;
}

-(UIButton *)detailButton
{
    if (!_detailButton) {
        _detailButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_detailButton setTitle:L(@"查看详情") forState:UIControlStateNormal];
        [_detailButton setTitleColor:ColorFromRGB(0xFFFFFF) forState:UIControlStateNormal];
        _detailButton.titleLabel.font = KFont(12);
        _detailButton.backgroundColor = ColorFromRGBA(0xB8B8B8, 0.1952);
        LayerMakeCorner(_detailButton, Auto_Width(16));
        _detailButton.enabled = NO;
        [self.backView addSubview:_detailButton];
        [_detailButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.right.mas_equalTo(Auto_Width(-17));
            make.size.mas_equalTo(CGSizeMake(Auto_Width(75), Auto_Width(28)));
        }];
    }
    return _detailButton;
}


@end

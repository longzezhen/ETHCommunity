//
//  ETHStoreListCell.m
//  ETHCommunity
//
//  Created by 龙泽桢 on 2019/6/5.
//  Copyright © 2019 tools. All rights reserved.
//

#import "ETHStoreListCell.h"
@interface ETHStoreListCell()
@property (nonatomic,strong)UILabel * storeNameLabel;
@property (nonatomic,strong)UIImageView * phoneImageView;
@property (nonatomic,strong)UILabel * phoneLabel;
@property (nonatomic,strong)UIImageView * addressImageView;
@property (nonatomic,strong)UILabel * addressLabel;
@property (nonatomic,strong)UILabel * distanceLabel;
@property (nonatomic,strong)UIView * bottomLineView;
@end

@implementation ETHStoreListCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.storeNameLabel.hidden = NO;
        self.phoneImageView.hidden = NO;
        self.phoneLabel.hidden = NO;
        self.addressImageView.hidden = NO;
        self.addressLabel.hidden = NO;
        self.distanceLabel.hidden = NO;
        self.bottomLineView.hidden = NO;
    }
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
    return self;
}

#pragma mark - get/set
-(void)setModel:(ETHStoreListModel *)model
{
    self.storeNameLabel.text = model.name;
    self.phoneLabel.text = model.contactWay;
    self.addressLabel.text = model.addr;
    self.distanceLabel.text = [NSString stringWithFormat:@"%@m",model.distance];
}

-(UILabel *)storeNameLabel
{
    if (!_storeNameLabel) {
        _storeNameLabel = [UILabel new];
        _storeNameLabel.text = @"南坡电子大厦店";
        _storeNameLabel.textColor = ColorFromRGB(0xFFFFFF);
        _storeNameLabel.font = KFont(16);
        [self.contentView addSubview:_storeNameLabel];
        [_storeNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(15);
            make.left.mas_equalTo(15);
        }];
    }
    return _storeNameLabel;
}

-(UIImageView *)phoneImageView
{
    if (!_phoneImageView) {
        _phoneImageView = [[UIImageView alloc]initWithImage:ImageNamed(@"icon_telephone")];
        [self.contentView addSubview:_phoneImageView];
        [_phoneImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(self.storeNameLabel.mas_bottom).mas_equalTo(12);
            make.size.mas_equalTo(CGSizeMake(10, 10));
        }];
    }
    return _phoneImageView;
}

-(UILabel *)phoneLabel
{
    if (!_phoneLabel) {
        _phoneLabel = [UILabel new];
        _phoneLabel.text = @"0755-83033399";
        _phoneLabel.textColor = ColorFromRGB(0x9B9B9B);
        _phoneLabel.font = KFont(12);
        [self.contentView addSubview:_phoneLabel];
        [_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.phoneImageView);
            make.left.mas_equalTo(self.phoneImageView.mas_right).mas_equalTo(6);
        }];
    }
    return _phoneLabel;
}

-(UIImageView *)addressImageView
{
    if (!_addressImageView) {
        _addressImageView = [[UIImageView alloc]initWithImage:ImageNamed(@"icon_location")];
        [self.contentView addSubview:_addressImageView];
        [_addressImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(self.phoneImageView.mas_bottom).mas_equalTo(11);
            make.size.mas_equalTo(CGSizeMake(10, 10));
        }];
    }
    return _addressImageView;
}

-(UILabel *)addressLabel
{
    if (!_addressLabel) {
        _addressLabel = [UILabel new];
        _addressLabel.text = @"南山区科技北三路1号南坡电子大厦一层";
        _addressLabel.textColor = ColorFromRGB(0x9B9B9B);
        _addressLabel.font = KFont(12);
        [self.contentView addSubview:_addressLabel];
        [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.addressImageView);
            make.left.mas_equalTo(self.addressImageView.mas_right).mas_equalTo(6);
        }];
    }
    return _addressLabel;
}

-(UILabel *)distanceLabel
{
    if (!_distanceLabel) {
        _distanceLabel = [UILabel new];
        _distanceLabel.text = @"700m";
        _distanceLabel.textColor = ColorFromRGB(0xFFFFFF);
        _distanceLabel.font = KFont(16);
        [self.contentView addSubview:_distanceLabel];
        [_distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.right.mas_equalTo(-15);
        }];
    }
    return _distanceLabel;
}

-(UIView *)bottomLineView
{
    if (!_bottomLineView) {
        _bottomLineView = [UIView new];
        _bottomLineView.backgroundColor = ColorFromRGBA(0x979797, 0.2);
        [self.contentView addSubview:_bottomLineView];
        [_bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.height.mas_equalTo(1);
        }];
    }
    return _bottomLineView;
}
@end

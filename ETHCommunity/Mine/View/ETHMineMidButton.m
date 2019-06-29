//
//  ETHMineMidButton.m
//  ETHCommunity
//
//  Created by 龙泽桢 on 2019/6/5.
//  Copyright © 2019 tools. All rights reserved.
//

#import "ETHMineMidButton.h"

@implementation ETHMineMidButton

-(instancetype)init
{
    if (self = [super init]) {
        self.topImageView.hidden = NO;
        self.bottomLabel.hidden = NO;
    }
    LayerMakeCorner(self, Auto_Width(4));
    self.backgroundColor = ColorFromRGBA(0xFFFFFF, 0.0549);
    return self;
}

#pragma mark - get
-(UIImageView *)topImageView
{
    if (!_topImageView) {
        _topImageView = [[UIImageView alloc] init];
        _topImageView.image = ImageNamed(@"icon_poromotion_registration");
        [self addSubview:_topImageView];
        [_topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(Auto_Width(34));
            make.size.mas_equalTo(CGSizeMake(Auto_Width(22), Auto_Width(20)));
        }];
    }
    return _topImageView;
}

-(UILabel *)bottomLabel
{
    if (!_bottomLabel) {
        _bottomLabel = [UILabel new];
        _bottomLabel.text = @"推广注册";
        _bottomLabel.textColor = ColorFromRGB(0xFFFFFF);
        _bottomLabel.font = KFont(11);
        [self addSubview:_bottomLabel];
        [_bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(self.topImageView.mas_bottom).mas_equalTo(Auto_Width(14));
        }];
    }
    return _bottomLabel;
}
@end

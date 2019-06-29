//
//  ETHEcologicalListCell.h
//  ETHCommunity
//
//  Created by 龙泽桢 on 2019/6/15.
//  Copyright © 2019 tools. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ETHEcologicalListCell : UITableViewCell
@property (nonatomic,strong) UIView * backView;
@property (nonatomic,strong) UIImageView * iconImageView;
@property (nonatomic,strong) UILabel * titleLabel;
@property (nonatomic,strong) UILabel * subTitleLabel;
@property (nonatomic,strong) UIButton * detailButton;
@property (nonatomic,strong) NSDictionary * dataDic;
@end

NS_ASSUME_NONNULL_END

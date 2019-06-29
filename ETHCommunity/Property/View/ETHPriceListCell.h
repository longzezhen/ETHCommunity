//
//  ETHPriceListCell.h
//  ETHCommunity
//
//  Created by 龙泽桢 on 2019/6/4.
//  Copyright © 2019 tools. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ETHPriceListCell : UITableViewCell
@property (nonatomic,strong)UIView * backView;
@property (nonatomic,strong)UILabel * leftLabel;
@property (nonatomic,strong)UILabel * middleLabel;
@property (nonatomic,strong)UILabel * rightLabel;
@property (nonatomic,strong)UIView * bottomLineView;

@property (nonatomic,strong)NSDictionary * dic;
@end


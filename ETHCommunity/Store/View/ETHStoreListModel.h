//
//  ETHStoreListModel.h
//  ETHCommunity
//
//  Created by 龙泽桢 on 2019/6/13.
//  Copyright © 2019 tools. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ETHStoreListModel : NSObject
@property (nonatomic,strong)NSString * name;//门店名
@property (nonatomic,strong)NSString * contactWay;//联系方式
@property (nonatomic,strong)NSString * addr;//位置
@property (nonatomic,strong)NSString * distance;//距离，单位.米
@property (nonatomic,strong)NSString * longitude;
@property (nonatomic,strong)NSString * latitude;
@end



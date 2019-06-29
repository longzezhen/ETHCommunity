//
//  BaseNetwork.h
//  ThreeSandOcean
//
//  Created by 龙泽桢 on 2019/5/27.
//  Copyright © 2019 tools. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^HttpSuccessBlock)(NSURLSessionDataTask * task,NSInteger resultCode,id resultObj);
typedef void(^HttpFailureBlock)(NSError *error);
@interface BaseNetwork : NSObject
@property (nonatomic,strong) AFHTTPSessionManager * manager;
@property (nonatomic,strong) AFHTTPSessionManager * formurlencodedManager;
+(BaseNetwork *)shareNetwork;

/**
 get网络请求 
 
 @param path url地址
 @param params url参数 id类型
 @param success 请求成功 返回NSDictionary或NSArray
 @param failure 请求失败 返回NSError
 */
- (void)getWithPath:(NSString *)path
             params:(id)params
            success:(HttpSuccessBlock)success
            failure:(HttpFailureBlock)failure;

/**
 post网络请求
 @param path url地址
 @param params url参数 id类型
 @param success 请求成功 返回NSDictionary或NSArray
 @param failure 请求失败 返回NSError
 */
-(void)postWithPath:(NSString *)path
             params:(id)params
            success:(HttpSuccessBlock)success
            failure:(HttpFailureBlock)failure;




- (void)getFormurlencodedWithPath:(NSString *)path
             params:(id)params
            success:(HttpSuccessBlock)success
            failure:(HttpFailureBlock)failure;

-(void)postFormurlencodedWithPath:(NSString *)path
             params:(id)params
            success:(HttpSuccessBlock)success
            failure:(HttpFailureBlock)failure;

-(void)postFormurlencodedWithPath:(NSString *)path
                            token:(NSString *)token
                           params:(id)params
                          success:(HttpSuccessBlock)success
                          failure:(HttpFailureBlock)failure;

//主要用来上传文件的函数
-(void)postFormdataWithPath:(NSString *)path
                          token:(NSString *)token
                         params:(id)params
                        success:(HttpSuccessBlock)success
                        failure:(HttpFailureBlock)failure;
@end



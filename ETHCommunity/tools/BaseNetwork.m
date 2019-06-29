//
//  BaseNetwork.m
//  ThreeSandOcean
//
//  Created by 龙泽桢 on 2019/5/27.
//  Copyright © 2019 tools. All rights reserved.
//

#import "BaseNetwork.h"
@interface BaseNetwork()

@end

@implementation BaseNetwork
+(BaseNetwork *)shareNetwork
{
    static BaseNetwork * shareNetwork = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareNetwork = [[BaseNetwork alloc] init];
    });
    return shareNetwork;
}

-(void)getWithPath:(NSString *)path params:(id)params success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure
{
    [self.manager GET:path parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(task,[responseObject[@"code"] integerValue],responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

-(void)postWithPath:(NSString *)path params:(id)params success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure
{
    [self.manager POST:path parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(task,[responseObject[@"code"] integerValue],responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

//Content type = application/x-www-form-urlencoded
- (void)getFormurlencodedWithPath:(NSString *)path
                           params:(id)params
                          success:(HttpSuccessBlock)success
                          failure:(HttpFailureBlock)failure
{
    [self.formurlencodedManager GET:path parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(task,[responseObject[@"code"] integerValue],responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

-(void)postFormurlencodedWithPath:(NSString *)path
                           params:(id)params
                          success:(HttpSuccessBlock)success
                          failure:(HttpFailureBlock)failure
{
    [self.formurlencodedManager POST:path parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(task,[responseObject[@"code"] integerValue],responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

-(void)postFormurlencodedWithPath:(NSString *)path
                            token:(NSString *)token
                           params:(id)params
                          success:(HttpSuccessBlock)success
                          failure:(HttpFailureBlock)failure
{
    //将token封装入请求头
    [self.formurlencodedManager.requestSerializer setValue:token forHTTPHeaderField:@"token"];
    [self.formurlencodedManager POST:path parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(task,[responseObject[@"code"] integerValue],responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

//主要用来上传文件的函数
-(void)postFormdataWithPath:(NSString *)path
                      token:(NSString *)token
                     params:(id)params
                    success:(HttpSuccessBlock)success
                    failure:(HttpFailureBlock)failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"multipart/form-data", @"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json", nil];
    manager.requestSerializer.timeoutInterval = 10;
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"token"];
    //设置请求内容的类型
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"multipart/form-data; boundary=%@",@"123456789"] forHTTPHeaderField:@"Content-Type"];
    
    [manager POST:path parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(task,[responseObject[@"code"] integerValue],responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
    
    

    [manager POST:path parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:[params mj_JSONData]
                                    name:@"DataName"
                                fileName:@"a.jpg"
                                mimeType:@"image/jpeg"];

    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(task,[responseObject[@"code"] integerValue],responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}


#pragma mark - get
-(AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
        _manager.requestSerializer = [AFJSONRequestSerializer serializer];
        _manager.responseSerializer = [AFJSONResponseSerializer serializer];
        AFSecurityPolicy * security = [AFSecurityPolicy defaultPolicy];
        security.allowInvalidCertificates = YES;
        security.validatesDomainName = NO;
        _manager.securityPolicy = security;
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"multipart/form-data", @"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json", nil];
     
        _manager.requestSerializer.timeoutInterval = 10;
    }
    return _manager;
}

-(AFHTTPSessionManager*)formurlencodedManager
{
    if (!_formurlencodedManager) {
        _formurlencodedManager = [AFHTTPSessionManager manager];
        _formurlencodedManager.requestSerializer = [AFHTTPRequestSerializer serializer];
        _formurlencodedManager.responseSerializer = [AFJSONResponseSerializer serializer];
        AFSecurityPolicy * security = [AFSecurityPolicy defaultPolicy];
        security.allowInvalidCertificates = YES;
        security.validatesDomainName = NO;
        _formurlencodedManager.securityPolicy = security;
        _formurlencodedManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"multipart/form-data", @"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json", nil];
        
        _formurlencodedManager.requestSerializer.timeoutInterval = 10;
    }
    return _formurlencodedManager;
}
@end

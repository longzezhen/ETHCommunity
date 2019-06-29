//
//  ETHChangeLoginPasswordViewController.m
//  ETHCommunity
//
//  Created by 龙泽桢 on 2019/6/11.
//  Copyright © 2019 tools. All rights reserved.
//

#import "ETHChangeLoginPasswordViewController.h"

@interface ETHChangeLoginPasswordViewController ()<WKNavigationDelegate>
@property (nonatomic,strong) BaseWKWebView * webView;
@end

@implementation ETHChangeLoginPasswordViewController

#pragma mark - lifeCycle
-(void)dealloc
{
    [self.webView removeObserver:self forKeyPath:@"title" context:nil];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

#pragma mark - private
-(void)initView
{
    self.title = @"修改登录密码";
    [self goBackBarButton];
    
    NSString * langStr = @"";
    if ([[RDLocalizableController userLanguage] isEqualToString:RDCHINESE]) {
        langStr = @"zh";
    }else{
        langStr = @"en";
    }
    NSString * urlStr = [NSString stringWithFormat:@"%@?&token=%@&language=%@",HTML_LoginPassword,TOKEN,langStr];
//    NSString * urlStr = [NSString stringWithFormat:@"%@?&token=%@",HTML_LoginPassword,TOKEN];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
}

#pragma mark - action
-(void)clickGoBackBarButton
{
    //判断是否能返回到H5上级页面
    if (self.webView.canGoBack==YES) {
        //返回上级页面
        [self.webView goBack];
        
    }else{
        [self.navigationController popViewControllerAnimated:YES];
        
    }
}

#pragma mark - WebviewTitleKVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"title"]) {
        self.title = self.webView.title;
    }
}

#pragma mark - WKNavigationDelegate

//请求之前，决定是否要跳转:用户点击网页上的链接，需要打开新页面时，将先调用这个方法。
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    if (navigationAction.navigationType == WKNavigationTypeLinkActivated || [[navigationAction.request URL].absoluteString containsString:@"www.modify_success.com"]){
        decisionHandler(WKNavigationActionPolicyCancel);
    }else{
        decisionHandler(WKNavigationActionPolicyAllow);
    }
    
    if ([[navigationAction.request URL].absoluteString containsString:@"www.modify_success.com"]) {
        [self.view showETHtoast:@"修改成功！"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
    }
    
}

#pragma mark - get
-(BaseWKWebView *)webView
{
    if (!_webView) {
        _webView = [[BaseWKWebView alloc]init];
        _webView.navigationDelegate = self;
        [_webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
        [self.view addSubview:_webView];
        [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }
    return _webView;
}


@end

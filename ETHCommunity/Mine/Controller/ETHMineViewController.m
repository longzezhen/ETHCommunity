//
//  ETHMineViewController.m
//  ETHCommunity
//
//  Created by 龙泽桢 on 2019/6/4.
//  Copyright © 2019 tools. All rights reserved.
//

#import "ETHMineViewController.h"
#import "ETHMineMidButton.h"
#import "ETHMineListButton.h"
#import "ETHMemberInfoViewController.h"
#import "ETHPromoteRegisterViewController.h"
#import "ETHScanRegisterViewController.h"
#import "ETHVIPPrepayViewController.h"
#import "ETHChangeLoginPasswordViewController.h"
#import "ETHChangeTransactionViewController.h"
#import "ETHAboutUsViewController.h"
@interface ETHMineViewController ()
@property (nonatomic,strong)UIButton * topButton;
//@property (nonatomic,strong)UIImageView * iconImageView;
@property (nonatomic,strong)UILabel * accountLabel;
@property (nonatomic,strong)UILabel * numberLabel;
@property (nonatomic,strong)UIImageView * arrowImageView;

@property (nonatomic,strong)ETHMineMidButton * promoteButton;
@property (nonatomic,strong)ETHMineMidButton * scanButton;
@property (nonatomic,strong)ETHMineMidButton * vipButton;

@property (nonatomic,strong)ETHMineListButton * logincodeButton;
@property (nonatomic,strong)ETHMineListButton * transactionButton;
@property (nonatomic,strong)ETHMineListButton * versionButton;
@property (nonatomic,strong)ETHMineListButton * aboutusButton;

@property (nonatomic,strong)ETHUserBaseInfo * userInfo;

@end

@implementation ETHMineViewController
#pragma mark - lifeCycle
-(void)dealloc
{
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.userInfo = [MYTools getUserInfo];
    [self initView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadUserInfo];
}

#pragma mark - private
-(void)initView
{
    self.title = L(@"我的");
    self.topButton.hidden = NO;
    self.promoteButton.hidden = NO;
    self.scanButton.hidden = NO;
    self.vipButton.hidden = NO;
    self.logincodeButton.hidden = NO;
    self.transactionButton.hidden = NO;
    self.versionButton.hidden = NO;
    self.aboutusButton.hidden = NO;
}

-(void)loadUserInfo
{
    [[BaseNetwork shareNetwork] postFormurlencodedWithPath:URL_UserInfo token:TOKEN params:nil success:^(NSURLSessionDataTask *task, NSInteger resultCode, id resultObj) {
        if (resultCode == 200) {
            if ([resultObj[@"data"] isKindOfClass:[NSDictionary class]]) {
                self.userInfo = [ETHUserBaseInfo mj_objectWithKeyValues:resultObj[@"data"]];
                [MYTools saveUserInfo:self.userInfo];
                self.accountLabel.text = self.userInfo.username;
                self.numberLabel.text = self.userInfo.nickName;
            }
        }else{
            [self.view showETHtoast:resultObj[@"msg"]];
        }
    } failure:^(NSError *error) {
        [self.view showETHtoast:@"网络错误"];
    }];
}


#pragma mark - action
-(void)clickTopButton
{
    ETHMemberInfoViewController * vc = [ETHMemberInfoViewController new];
    [BaseNavViewController pushViewController:vc hiddenBottomWhenPush:YES animation:YES fromNavigation:self.navigationController];
}

-(void)clickPromoteButton
{
    ETHPromoteRegisterViewController * vc = [ETHPromoteRegisterViewController new];
    [BaseNavViewController pushViewController:vc hiddenBottomWhenPush:YES animation:YES fromNavigation:self.navigationController];
}

-(void)clickScanButton
{
    ETHScanRegisterViewController * vc = [ETHScanRegisterViewController new];
    [BaseNavViewController pushViewController:vc hiddenBottomWhenPush:YES animation:YES fromNavigation:self.navigationController];
}

-(void)clickVipButton
{
    ETHVIPPrepayViewController * vc = [ETHVIPPrepayViewController new];
    [BaseNavViewController pushViewController:vc hiddenBottomWhenPush:YES animation:YES fromNavigation:self.navigationController];
}

-(void)clickLogincodeButton
{
    ETHChangeLoginPasswordViewController * vc = [ETHChangeLoginPasswordViewController new];
    [BaseNavViewController pushViewController:vc hiddenBottomWhenPush:YES animation:YES fromNavigation:self.navigationController];
}

-(void)clickTransactionButton
{
    ETHChangeTransactionViewController * vc = [ETHChangeTransactionViewController new];
    [BaseNavViewController pushViewController:vc hiddenBottomWhenPush:YES animation:YES fromNavigation:self.navigationController];
}

-(void)clickVersionButton
{
    [self.view showETHtoast:L(@"已经是最新版本")];
}

-(void)clickAboutusButton
{
    ETHAboutUsViewController * vc = [ETHAboutUsViewController new];
    [BaseNavViewController pushViewController:vc hiddenBottomWhenPush:YES animation:YES fromNavigation:self.navigationController];
}
#pragma mark - get
-(UIButton *)topButton
{
    if (!_topButton) {
        _topButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _topButton.backgroundColor = ColorFromRGBA(0xFFFFFF, 0.0549);
        [_topButton addTarget:self action:@selector(clickTopButton) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_topButton];
        [_topButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(Auto_Width(10));
            make.height.mas_equalTo(Auto_Width(90));
        }];
        
        //self.iconImageView.hidden = NO;
        self.accountLabel.hidden = NO;
        self.numberLabel.hidden = NO;
        self.arrowImageView.hidden = NO;
    }
    return _topButton;
}

//-(UIImageView *)iconImageView
//{
//    if (!_iconImageView) {
//        _iconImageView = [[UIImageView alloc] init];
//        [_iconImageView sd_setImageWithURL:[NSURL URLWithString:self.userInfo.headUrl] placeholderImage:ImageNamed(@"icon_ecology_select")];
//        LayerMakeCorner(_iconImageView, Auto_Width(45/2));
//        [self.topButton addSubview:_iconImageView];
//        [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerY.mas_equalTo(0);
//            make.left.mas_equalTo(Auto_Width(25));
//            make.size.mas_equalTo(CGSizeMake(Auto_Width(45), Auto_Width(45)));
//        }];
//    }
//    return _iconImageView;
//}

-(UILabel *)accountLabel
{
    if (!_accountLabel) {
        _accountLabel = [UILabel new];
        _accountLabel.text = self.userInfo.username;
        _accountLabel.textColor = ColorFromRGB(0xFFFFFF);
        _accountLabel.font = KFont(15);
        [self.topButton addSubview:_accountLabel];
        [_accountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(Auto_Width(25));
            make.left.mas_equalTo(Auto_Width(25));
        }];
    }
    return _accountLabel;
}

-(UILabel *)numberLabel
{
    if (!_numberLabel) {
        _numberLabel = [UILabel new];
        _numberLabel.text = self.userInfo.nickName;
        _numberLabel.textColor = ColorFromRGB(0xFFFFFF);
        _numberLabel.font = KFont(13);
        [self.topButton addSubview:_numberLabel];
        [_numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(Auto_Width(-25));
            make.left.mas_equalTo(Auto_Width(25));
        }];
    }
    return _numberLabel;
}

-(UIImageView *)arrowImageView
{
    if (!_arrowImageView) {
        _arrowImageView = [[UIImageView alloc] initWithImage:ImageNamed(@"icon_into_arrow")];
        [self.topButton addSubview:_arrowImageView];
        [_arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.right.mas_equalTo(Auto_Width(-19));
            make.size.mas_equalTo(CGSizeMake(Auto_Width(6), Auto_Width(11)));
        }];
    }
    return _arrowImageView;
}

-(ETHMineMidButton *)promoteButton
{
    if (!_promoteButton) {
        _promoteButton = [[ETHMineMidButton alloc] init];
        _promoteButton.topImageView.image = ImageNamed(@"icon_poromotion_registration");
        _promoteButton.bottomLabel.text = L(@"推广注册");
        [_promoteButton addTarget:self action:@selector(clickPromoteButton) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_promoteButton];
        [_promoteButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.topButton.mas_bottom).mas_equalTo(Auto_Width(20));
            make.left.mas_equalTo(Auto_Width(15));
            make.size.mas_equalTo(CGSizeMake(Auto_Width(105), Auto_Width(110)));
        }];
    }
    return _promoteButton;
}

-(ETHMineMidButton *)scanButton
{
    if (!_scanButton) {
        _scanButton = [[ETHMineMidButton alloc] init];
        _scanButton.topImageView.image = ImageNamed(@"icon_scan");
        _scanButton.bottomLabel.text = L(@"扫码注册");
        [_scanButton addTarget:self action:@selector(clickScanButton) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_scanButton];
        [_scanButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.topButton.mas_bottom).mas_equalTo(Auto_Width(20));
            make.centerX.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(Auto_Width(105), Auto_Width(110)));
        }];
    }
    return _scanButton;
}

-(ETHMineMidButton *)vipButton
{
    if (!_vipButton) {
        _vipButton = [[ETHMineMidButton alloc] init];
        _vipButton.topImageView.image = ImageNamed(@"icon_vip_recharge");
        _vipButton.bottomLabel.text = L(@"VIP充值");
        [_vipButton addTarget:self action:@selector(clickVipButton) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_vipButton];
        [_vipButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.topButton.mas_bottom).mas_equalTo(Auto_Width(20));
            make.right.mas_equalTo(Auto_Width(-15));
            make.size.mas_equalTo(CGSizeMake(Auto_Width(105), Auto_Width(110)));
        }];
    }
    return _vipButton;
}

-(ETHMineListButton *)logincodeButton
{
    if (!_logincodeButton) {
        _logincodeButton = [[ETHMineListButton alloc] init];
        _logincodeButton.leftImageView.image = ImageNamed(@"icon_login_password");
        _logincodeButton.middleLabel.text = L(@"登录密码");
        [_logincodeButton addTarget:self action:@selector(clickLogincodeButton) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_logincodeButton];
        [_logincodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(self.promoteButton.mas_bottom).mas_equalTo(Auto_Width(20));
            make.height.mas_equalTo(Auto_Width(55));
        }];
    }
    return _logincodeButton;
}

-(ETHMineListButton *)transactionButton
{
    if (!_transactionButton) {
        _transactionButton = [[ETHMineListButton alloc] init];
        _transactionButton.leftImageView.image = ImageNamed(@"icon_transaction_password");
        _transactionButton.middleLabel.text = L(@"交易密码");
        [_transactionButton addTarget:self action:@selector(clickTransactionButton) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_transactionButton];
        [_transactionButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(self.logincodeButton.mas_bottom).mas_equalTo(Auto_Width(10));
            make.height.mas_equalTo(Auto_Width(55));
        }];
    }
    return _transactionButton;
}

-(ETHMineListButton *)versionButton
{
    if (!_versionButton) {
        _versionButton = [[ETHMineListButton alloc] init];
        _versionButton.leftImageView.image = ImageNamed(@"icon_version_update");
        _versionButton.middleLabel.text = L(@"版本更新");
        [_versionButton addTarget:self action:@selector(clickVersionButton) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_versionButton];
        [_versionButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(self.transactionButton.mas_bottom).mas_equalTo(Auto_Width(10));
            make.height.mas_equalTo(Auto_Width(55));
        }];
    }
    return _versionButton;
}

-(ETHMineListButton *)aboutusButton
{
    if (!_aboutusButton) {
        _aboutusButton = [[ETHMineListButton alloc] init];
        _aboutusButton.leftImageView.image = ImageNamed(@"icon_about_us");
        _aboutusButton.middleLabel.text = L(@"关于我们");
        [_aboutusButton addTarget:self action:@selector(clickAboutusButton) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_aboutusButton];
        [_aboutusButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(self.versionButton.mas_bottom).mas_equalTo(Auto_Width(10));
            make.height.mas_equalTo(Auto_Width(55));
        }];
    }
    return _aboutusButton;
}
@end

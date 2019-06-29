//
//  ETHLoginViewController.m
//  ETHCommunity
//
//  Created by 龙泽桢 on 2019/6/3.
//  Copyright © 2019 tools. All rights reserved.
//

#import "ETHLoginViewController.h"
#import "ETHListView.h"
#import "ETHZJCLoginViewController.h"
#import "UIImage+GIF.h"
#import "ETHZJCCopyViewController.h"
#import "FLAnimatedImageView+WebCache.h"
@interface ETHLoginViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) FLAnimatedImageView *backIamgeView;
//@property (nonatomic,strong)UIImageView * backIamgeView;
@property (nonatomic,strong)UIButton * backButton;
@property (nonatomic,strong)UILabel * titleLabel;
@property (nonatomic,strong)ETHListView * accountView;
@property (nonatomic,strong)ETHListView * passwordView;
@property (nonatomic,strong)UIButton * loginButton;
@property (nonatomic,strong)UIButton * mnemonicButton;
@property (nonatomic,strong)UIButton * registerButton;
@end

@implementation ETHLoginViewController
#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    [self initView];
}

#pragma mark - private
-(void)initView
{
    self.backIamgeView.hidden = NO;
    self.backButton.hidden = NO;
    self.titleLabel.hidden = NO;
    self.accountView.hidden = NO;
    self.passwordView.hidden = NO;
    self.loginButton.hidden = NO;
    self.mnemonicButton.hidden = NO;
    self.registerButton.hidden = NO;
}

#pragma mark - action
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    END_EDITING;
}

-(void)clickGoBackButton
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)clickLoginButton
{
    if (self.accountView.rightTextField.text.length != 11) {
        [self.view showETHtoast:L(@"请输入会员账号")];
        return;
    }
    
    if (self.passwordView.rightTextField.text.length == 0) {
        [self.view showETHtoast:L(@"请输入密码")];
        return;
    }
    NSDictionary * paramsDic = @{@"userName":self.accountView.rightTextField.text,@"password":self.passwordView.rightTextField.text};
    
    [[BaseNetwork shareNetwork] postFormurlencodedWithPath:URL_userLogin params:paramsDic success:^(NSURLSessionDataTask *task, NSInteger resultCode, id resultObj) {
        if (resultCode == 200) {
            NSString * object = [NSString stringWithFormat:@"%@",resultObj[@"data"][@"token"]];
            if (object) {
                [[NSUserDefaults standardUserDefaults] setObject:object forKey:@"token"];
            }
            [[NSUserDefaults standardUserDefaults] setObject:self.accountView.rightTextField.text forKey:@"account"];
            [[NSUserDefaults standardUserDefaults] setObject:self.passwordView.rightTextField.text forKey:@"password"];
            
            NSDictionary * userInfoDic = resultObj[@"data"][@"userInfoDTO"];
            ETHUserBaseInfo * userInfo = [ETHUserBaseInfo mj_objectWithKeyValues:userInfoDic];
            [MYTools saveUserInfo:userInfo];
            if ([userInfo.verifyStatus integerValue] == 0) {//未验证助记词
                ETHZJCCopyViewController * vc = [ETHZJCCopyViewController new];
                vc.isFromLogin = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                [AppDelegate startMainViewController];
            }
        }else{
            [self.view showETHtoast:resultObj[@"msg"]];
        }
    } failure:^(NSError *error) {
        [self.view showETHtoast:@"网络异常"];
    }];
    
    
}

-(void)clickMnemonicButton
{
    ETHZJCLoginViewController * vc = [ETHZJCLoginViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)clickRegisterButton
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITextFieldDelegate
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    END_EDITING;
    return YES;
}

#pragma mark - get
-(FLAnimatedImageView*)backIamgeView
{
    if (!_backIamgeView) {
        _backIamgeView = [[FLAnimatedImageView alloc] init];
        [self.view addSubview:_backIamgeView];
        [_backIamgeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        
//        NSData * gifData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"login_back" ofType:@"gif"]];
//        _backIamgeView.image = [UIImage sd_animatedGIFWithData:gifData];
        NSURL *imgUrl = [[NSBundle mainBundle] URLForResource:@"login_back" withExtension:@"gif"];
        [_backIamgeView sd_setImageWithURL:imgUrl];
    }
    return _backIamgeView;
}


-(UIButton *)backButton
{
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backButton setImage:ImageNamed(@"icon_return") forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(clickGoBackButton) forControlEvents:UIControlEventTouchUpInside];
        _backButton.imageEdgeInsets = UIEdgeInsetsMake(0, -Auto_Width(30), 0, 0);
        [self.view addSubview:_backButton];
        [_backButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Auto_Width(15));
            make.top.mas_equalTo(Auto_Width(35)+KTopHeight);
            make.size.mas_equalTo(CGSizeMake(Auto_Width(40), Auto_Height(15)));
        }];
    }
    return _backButton;
}

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.text = L(@"登录");
        _titleLabel.textColor = ColorFromRGB(0xFFFFFF);
        _titleLabel.font = KFont(20);
        [self.view addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(Auto_Width(75)+KTopHeight);
        }];
    }
    return _titleLabel;
}

-(ETHListView *)accountView
{
    if (!_accountView) {
        _accountView = [[ETHListView alloc] init];
        _accountView.leftLabel.text = L(@"会员账号");
        _accountView.rightTextField.placeholder = L(@"请输入会员账号");
        _accountView.rightTextField.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"account"];
        _accountView.rightTextField.delegate = self;
        [self.view addSubview:_accountView];
        [_accountView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.titleLabel).mas_equalTo(Auto_Width(71));
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(Auto_Width(59));
        }];
    }
    return _accountView;
}

-(ETHListView *)passwordView
{
    if (!_passwordView) {
        _passwordView = [[ETHListView alloc] init];
        _passwordView.leftLabel.text = L(@"密码");
        _passwordView.rightTextField.placeholder = L(@"请输入密码");
        _passwordView.rightTextField.secureTextEntry = YES;
        _passwordView.rightTextField.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
        _passwordView.rightTextField.delegate = self;
        [self.view addSubview:_passwordView];
        [_passwordView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.accountView.mas_bottom);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(Auto_Width(59));
        }];
    }
    return _passwordView;
}

-(UIButton *)loginButton
{
    if (!_loginButton) {
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginButton setTitle:L(@"立即登录") forState:UIControlStateNormal];
        [_loginButton setTitleColor:ColorFromRGB(0xFFFFFF) forState:UIControlStateNormal];
        _loginButton.titleLabel.font = KFont(15);
        LayerMakeCorner(_loginButton, Auto_Width(23));
        _loginButton.backgroundColor = ColorFromRGB(0x2B2D39);
        [_loginButton addTarget:self action:@selector(clickLoginButton) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_loginButton];
        [_loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(self.passwordView.mas_bottom).mas_equalTo(Auto_Width(112));
            make.size.mas_equalTo(CGSizeMake(Auto_Width(320), Auto_Width(45)));
        }];
    }
    return _loginButton;
}

-(UIButton *)mnemonicButton
{
    if (!_mnemonicButton) {
        _mnemonicButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_mnemonicButton setTitle:L(@"助记词登录") forState:UIControlStateNormal];
        [_mnemonicButton setTitleColor:ColorFromRGB(0xD8D8D8) forState:UIControlStateNormal];
        _mnemonicButton.titleLabel.font = KFont(13);
        [_mnemonicButton addTarget:self action:@selector(clickMnemonicButton) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_mnemonicButton];
        [_mnemonicButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.loginButton.mas_bottom).mas_equalTo(Auto_Width(11));
            make.right.mas_equalTo(self.loginButton);
            make.size.mas_equalTo(CGSizeMake(Auto_Width(66), Auto_Width(18)));
        }];
    }
    return _mnemonicButton;
}

-(UIButton *)registerButton
{
    if (!_registerButton) {
        _registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_registerButton setTitle:L(@"立即注册") forState:UIControlStateNormal];
        [_registerButton setTitleColor:ColorFromRGB(0xD8D8D8) forState:UIControlStateNormal];
        _registerButton.titleLabel.font = KFont(14);
        [_registerButton addTarget:self action:@selector(clickRegisterButton) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_registerButton];
        [_registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.bottom.mas_equalTo(Auto_Width(-40));
            make.size.mas_equalTo(CGSizeMake(Auto_Width(56), Auto_Width(20)));
        }];
    }
    return _registerButton;
}
@end

//
//  ETHRegisterViewController.m
//  ETHCommunity
//
//  Created by 龙泽桢 on 2019/6/3.
//  Copyright © 2019 tools. All rights reserved.
//

#import "ETHRegisterViewController.h"
#import "ETHListView.h"
#import "ETHLoginViewController.h"
#import "ETHZJCCopyViewController.h"
@interface ETHRegisterViewController ()<UITextFieldDelegate>
@property (nonatomic,strong)UIButton * backButton;
@property (nonatomic,strong)UILabel * titleLabel;
@property (nonatomic,strong)ETHListView * accountView;
@property (nonatomic,strong)ETHListView * nameView;
@property (nonatomic,strong)ETHListView * passwordView;
@property (nonatomic,strong)ETHListView * rePasswordView;
@property (nonatomic,strong)ETHListView * dealPasswordView;
@property (nonatomic,strong)ETHListView * reDealPasswordView;
@property (nonatomic,strong)ETHListView * invitationCodeView;
@property (nonatomic,strong)UIButton * registerButton;
@property (nonatomic,strong)UIButton * loginButton;
@end

@implementation ETHRegisterViewController
#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

#pragma mark - pivate
-(void)initView
{
    self.backButton.hidden = NO;
    self.titleLabel.hidden = NO;
    self.accountView.hidden = NO;
    self.nameView.hidden = NO;
    self.passwordView.hidden = NO;
    self.rePasswordView.hidden = NO;
    self.dealPasswordView.hidden = NO;
    self.reDealPasswordView.hidden = NO;
    self.invitationCodeView.hidden = NO;
    self.loginButton.hidden = NO;
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
    ETHLoginViewController * vc = [ETHLoginViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)clickRegisterButton
{
    if (self.accountView.rightTextField.text.length != 11) {
        [self.view showETHtoast:@"请输入11位账号"];
        return;
    }
    
    if (self.nameView.rightTextField.text.length<3||self.nameView.rightTextField.text.length>15) {
        [self.view showETHtoast:@"请输入3-15位姓名"];
        return;
    }
    
    if (self.passwordView.rightTextField.text.length<6||self.passwordView.rightTextField.text.length>12) {
        [self.view showETHtoast:@"请输入6-12位字母数字密码"];
        return;
    }
    
    if(![self.rePasswordView.rightTextField.text isEqualToString:self.passwordView.rightTextField.text]){
        [self.view showETHtoast:@"登录密码确认有误"];
        return;
    }
    
    if (self.dealPasswordView.rightTextField.text.length != 6) {
        [self.view showETHtoast:@"请输入6位交易密码"];
        return;
    }
    
    if (![self.reDealPasswordView.rightTextField.text isEqualToString:self.dealPasswordView.rightTextField.text]) {
        [self.view showETHtoast:@"交易密码确认有误"];
        return;
    }
    
    if (self.invitationCodeView.rightTextField.text.length == 0) {
        [self.view showETHtoast:@"请输入邀请码"];
        return;
    }
    
    NSDictionary * paramasDic = @{@"userName":self.accountView.rightTextField.text,@"nickName":self.nameView.rightTextField.text,@"firstPassword":self.passwordView.rightTextField.text,@"secondPassword":self.rePasswordView.rightTextField.text,@"firstTradePassword":self.dealPasswordView.rightTextField.text,@"secondTradePassword":self.reDealPasswordView.rightTextField.text,@"inviteCode":self.invitationCodeView.rightTextField.text};
    
    [[BaseNetwork shareNetwork] postWithPath:URL_userRegister params:paramasDic success:^(NSURLSessionDataTask *task, NSInteger resultCode, id resultObj) {
        if (resultCode == 200) {
            NSString * object = [NSString stringWithFormat:@"%@",resultObj[@"data"][@"token"]];
            if (object) {
                [[NSUserDefaults standardUserDefaults] setObject:object forKey:@"registerToken"];
            }
            ETHZJCCopyViewController * vc = [ETHZJCCopyViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            [self.view showETHtoast:resultObj[@"msg"]];
        }
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - UITextFieldDelegate
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == self.reDealPasswordView.rightTextField) {
        [UIView animateWithDuration:0.2 animations:^{
            self.view.frame = CGRectMake(0, -50, self.view.bounds.size.width, self.view.bounds.size.height);
        }];
    }
    
    if (textField == self.invitationCodeView.rightTextField) {
        [UIView animateWithDuration:0.2 animations:^{
            self.view.frame = CGRectMake(0, -100, self.view.bounds.size.width, self.view.bounds.size.height);
        }];
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.2 animations:^{
        self.view.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    END_EDITING;
    return YES;
}

#pragma mark - get
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
        _titleLabel.text = L(@"注册");
        _titleLabel.textColor = ColorFromRGB(0xFFFFFF);
        _titleLabel.font = KFont(16);
        [self.view addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.centerY.mas_equalTo(self.backButton);
        }];
    }
    return _titleLabel;
}

-(ETHListView *)accountView
{
    if (!_accountView) {
        _accountView = [[ETHListView alloc] init];
        _accountView.leftLabel.text = L(@"会员账号");
        _accountView.rightTextField.placeholder = L(@"11位字母+数字组合");
        _accountView.rightTextField.delegate = self;
        [self.view addSubview:_accountView];
        [_accountView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(Auto_Width(65)+KTopHeight);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(Auto_Width(59));
        }];
    }
    return _accountView;
}

-(ETHListView *)nameView
{
    if (!_nameView) {
        _nameView = [[ETHListView alloc] init];
        _nameView.leftLabel.text = L(@"会员姓名");
        _nameView.rightTextField.placeholder = L(@"3-15位,可包含中英文及下划线");
        _nameView.rightTextField.delegate = self;
        [self.view addSubview:_nameView];
        [_nameView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.accountView.mas_bottom);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(Auto_Width(59));
        }];
    }
    return _nameView;
}

-(ETHListView *)passwordView
{
    if (!_passwordView) {
        _passwordView = [[ETHListView alloc] init];
        _passwordView.leftLabel.text = L(@"登录密码");
        _passwordView.rightTextField.placeholder = L(@"请输入登录密码(6-12位字母+数字)");
        _passwordView.rightTextField.delegate = self;
        [self.view addSubview:_passwordView];
        [_passwordView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.nameView.mas_bottom);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(Auto_Width(59));
        }];
    }
    return _passwordView;
}

-(ETHListView *)rePasswordView
{
    if (!_rePasswordView) {
        _rePasswordView = [[ETHListView alloc] init];
        _rePasswordView.leftLabel.text = L(@"确认登录密码");
        _rePasswordView.rightTextField.placeholder = L(@"请确认登录密码");
        _rePasswordView.rightTextField.delegate = self;
        [self.view addSubview:_rePasswordView];
        [_rePasswordView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.passwordView.mas_bottom);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(Auto_Width(59));
        }];
    }
    return _rePasswordView;
}

-(ETHListView *)dealPasswordView
{
    if (!_dealPasswordView) {
        _dealPasswordView = [[ETHListView alloc] init];
        _dealPasswordView.leftLabel.text = L(@"交易密码");
        _dealPasswordView.rightTextField.placeholder = L(@"请输入交易密码(6位数字)");
        _dealPasswordView.rightTextField.keyboardType = UIKeyboardTypePhonePad;
        _dealPasswordView.rightTextField.delegate = self;
        [self.view addSubview:_dealPasswordView];
        [_dealPasswordView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.rePasswordView.mas_bottom);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(Auto_Width(59));
        }];
    }
    return _dealPasswordView;
}

-(ETHListView *)reDealPasswordView
{
    if (!_reDealPasswordView) {
        _reDealPasswordView = [[ETHListView alloc] init];
        _reDealPasswordView.leftLabel.text = L(@"确认交易密码");
        _reDealPasswordView.rightTextField.placeholder = L(@"请确认交易密码(6位数字)");
        _reDealPasswordView.rightTextField.keyboardType = UIKeyboardTypePhonePad;
        _reDealPasswordView.rightTextField.delegate = self;
        [self.view addSubview:_reDealPasswordView];
        [_reDealPasswordView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.dealPasswordView.mas_bottom);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(Auto_Width(59));
        }];
    }
    return _reDealPasswordView;
}

-(ETHListView *)invitationCodeView
{
    if (!_invitationCodeView) {
        _invitationCodeView = [[ETHListView alloc] init];
        _invitationCodeView.leftLabel.text = L(@"邀请码");
        _invitationCodeView.rightTextField.placeholder = L(@"请输入邀请码");
        _invitationCodeView.rightTextField.delegate = self;
        [self.view addSubview:_invitationCodeView];
        [_invitationCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.reDealPasswordView.mas_bottom);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(Auto_Width(59));
        }];
    }
    return _invitationCodeView;
}

-(UIButton *)loginButton
{
    if (!_loginButton) {
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginButton setTitle:L(@"已有账号，立即登录") forState:UIControlStateNormal];
        [_loginButton setTitleColor:ColorFromRGB(0xD8D8D8) forState:UIControlStateNormal];
        _loginButton.titleLabel.font = KFont(14);
        [_loginButton addTarget:self action:@selector(clickLoginButton) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_loginButton];
        [_loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(Auto_Width(-40));
            make.centerX.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(Auto_Width(126), Auto_Width(20)));
        }];
    }
    return _loginButton;
}

-(UIButton *)registerButton
{
    if (!_registerButton) {
        _registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_registerButton setTitle:L(@"立即注册") forState:UIControlStateNormal];
        [_registerButton setTitleColor:ColorFromRGB(0xFFFFFF) forState:UIControlStateNormal];
        _registerButton.titleLabel.font = KFont(15);
        LayerMakeCorner(_registerButton, Auto_Width(23));
        _registerButton.backgroundColor = ColorFromRGB(0x2B2D39);
        [_registerButton addTarget:self action:@selector(clickRegisterButton) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_registerButton];
        [_registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.bottom.mas_equalTo(self.loginButton.mas_top).mas_equalTo(Auto_Width(-19));
            make.size.mas_equalTo(CGSizeMake(Auto_Width(320), Auto_Width(45)));
        }];
    }
    return _registerButton;
}
@end

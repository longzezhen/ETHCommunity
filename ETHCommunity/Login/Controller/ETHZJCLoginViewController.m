//
//  ETHZJCLoginViewController.m
//  ETHCommunity
//
//  Created by 龙泽桢 on 2019/6/3.
//  Copyright © 2019 tools. All rights reserved.
//

#import "ETHZJCLoginViewController.h"
#import "ETHRegisterViewController.h"
@interface ETHZJCLoginViewController ()<UITextViewDelegate>
@property (nonatomic,strong)UIButton * backButton;
@property (nonatomic,strong)UILabel * titleLabel;
@property (nonatomic,strong)UILabel * ZJCLabel;
@property (nonatomic,strong)UITextView * ZJCTextView;
@property (nonatomic,strong)UIButton * loginButton;
@property (nonatomic,strong)UIButton * accountButton;
@property (nonatomic,strong)UIButton * registerButton;
@end

@implementation ETHZJCLoginViewController
#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

#pragma mark - private
-(void)initView
{
    self.backButton.hidden = NO;
    self.titleLabel.hidden = NO;
    self.ZJCLabel.hidden = NO;
    self.ZJCTextView.hidden = NO;
    self.loginButton.hidden = NO;
    self.accountButton.hidden = NO;
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
    if ([self.ZJCTextView.text isEqualToString:L(@"请按顺序输入助记词(单词之间请用空格隔开)")]) {
        [self.view showETHtoast:L(@"请输入助记词")];
        return;
    }
    
    [[BaseNetwork shareNetwork] postFormurlencodedWithPath:URL_ZJCLogin params:@{@"words":self.ZJCTextView.text} success:^(NSURLSessionDataTask *task, NSInteger resultCode, id resultObj) {
        if (resultCode == 200) {
            NSString * object = [NSString stringWithFormat:@"%@",resultObj[@"data"][@"token"]];
            if (object) {
                [[NSUserDefaults standardUserDefaults] setObject:object forKey:@"token"];
            }
            
            NSDictionary * userInfoDic = resultObj[@"data"][@"userInfoDTO"];
            ETHUserBaseInfo * userInfo = [ETHUserBaseInfo mj_objectWithKeyValues:userInfoDic];
            [MYTools saveUserInfo:userInfo];
            
            [AppDelegate startMainViewController];
        }else{
            [self.view showETHtoast:resultObj[@"msg"]];
        }
    } failure:^(NSError *error) {
        [self.view showETHtoast:@"网络错误"];
    }];
}

-(void)clickAccountButton
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)clickRegisterButton
{
    for (BaseViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[ETHRegisterViewController class]]) {
            ETHRegisterViewController *vc = (ETHRegisterViewController *)controller;
            [self.navigationController popToViewController:vc animated:YES];
            return;
        }
    }
}

#pragma mark - UITextViewDelegate
-(void)textViewDidChange:(UITextView *)textView
{
   
}


-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        END_EDITING;
        return NO;
    }
    return YES;
}

//已经进入编辑模式
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if([textView.text isEqualToString:L(@"请按顺序输入助记词(单词之间请用空格隔开)")]){
        textView.text=@"";
        textView.textColor = ColorFromRGB(0xFFFFFF);
    }
}

//已经结束/退出编辑模式
- (void)textViewDidEndEditing:(UITextView *)textView
{
    if(textView.text.length < 1){
        textView.text = L(@"请按顺序输入助记词(单词之间请用空格隔开)");
        textView.textColor = ColorFromRGB(0x909090);
    }
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

-(UILabel *)ZJCLabel
{
    if (!_ZJCLabel) {
        _ZJCLabel = [UILabel new];
        _ZJCLabel.text = L(@"助记词");
        _ZJCLabel.textColor = ColorFromRGB(0xFFFFFF);
        _ZJCLabel.font = KFont(15);
        [self.view addSubview:_ZJCLabel];
        [_ZJCLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_equalTo(Auto_Width(60));
            make.left.mas_equalTo(Auto_Width(15));
        }];
    }
    return _ZJCLabel;
}

-(UITextView *)ZJCTextView
{
    if (!_ZJCTextView) {
        _ZJCTextView = [UITextView new];
        _ZJCTextView.textContainerInset = UIEdgeInsetsMake(17, 13, 17, 13);
        _ZJCTextView.textColor = ColorFromRGB(0x909090);
        _ZJCTextView.text = L(@"请按顺序输入助记词(单词之间请用空格隔开)");
        _ZJCTextView.font = KFont(13);
        _ZJCTextView.backgroundColor = ColorFromRGBA(0xFFFFFF, 0.0477);
        _ZJCTextView.delegate = self;
        [self.view addSubview:_ZJCTextView];
        [_ZJCTextView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.ZJCLabel.mas_bottom).mas_equalTo(Auto_Width(8));
            make.left.mas_equalTo(Auto_Width(15));
            make.right.mas_equalTo(Auto_Width(-15));
            make.height.mas_equalTo(Auto_Width(130));
        }];
    }
    return _ZJCTextView;
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
            make.top.mas_equalTo(self.ZJCTextView.mas_bottom).mas_equalTo(Auto_Width(60));
            make.size.mas_equalTo(CGSizeMake(Auto_Width(320), Auto_Width(45)));
        }];
    }
    return _loginButton;
}

-(UIButton *)accountButton
{
    if (!_accountButton) {
        _accountButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_accountButton setTitle:L(@"账号密码登录") forState:UIControlStateNormal];
        [_accountButton setTitleColor:ColorFromRGB(0xD8D8D8) forState:UIControlStateNormal];
        _accountButton.titleLabel.font = KFont(13);
        [_accountButton addTarget:self action:@selector(clickAccountButton) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_accountButton];
        [_accountButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.loginButton.mas_bottom).mas_equalTo(Auto_Width(11));
            make.right.mas_equalTo(self.loginButton);
            make.size.mas_equalTo(CGSizeMake(Auto_Width(79), Auto_Width(18)));
        }];
    }
    return _accountButton;
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
            make.bottom.mas_equalTo(Auto_Width(-44));
            make.size.mas_equalTo(CGSizeMake(Auto_Width(56), Auto_Width(20)));
        }];
    }
    return _registerButton;
}
@end

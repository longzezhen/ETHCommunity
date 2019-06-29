//
//  ETHSelectLanguageViewController.m
//  ETHCommunity
//
//  Created by 龙泽桢 on 2019/5/31.
//  Copyright © 2019 tools. All rights reserved.
//

#import "ETHSelectLanguageViewController.h"
#import "ETHRegisterViewController.h"
@interface ETHSelectLanguageViewController ()
@property (nonatomic,strong)UILabel * titleLabel;
@property (nonatomic,strong)UILabel * contentLabel;
@property (nonatomic,strong)UIButton * engButton;
@property (nonatomic,strong)UIButton * cnButton;
@end

@implementation ETHSelectLanguageViewController
#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

#pragma mark - private
-(void)initView
{
    self.titleLabel.hidden = NO;
    self.contentLabel.hidden = NO;
    self.engButton.hidden = NO;
    self.cnButton.hidden = NO;
    
}

#pragma mark - action
-(void)clickEngButton
{
//    //修改语言
//    NSString *language = [SwitchLanguage userLanguage];
//
//    if ([language isEqualToString:@"en"]) {
//        [SwitchLanguage setUserlanguage:@"zh-Hans"];
//
//    }else{
//        [SwitchLanguage setUserlanguage:@"en"];
//    }
//
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeLanguage"object:self];
    [RDLocalizableController setUserlanguage:RDENGLISH];
    ETHRegisterViewController * vc = [ETHRegisterViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)clickCnButton
{
    [RDLocalizableController setUserlanguage:RDCHINESE];
    ETHRegisterViewController * vc = [ETHRegisterViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - get
- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.text = @"Select language";
        _titleLabel.textColor = ColorFromRGB(0xFFFFFF);
        _titleLabel.font = KFont(20);
        [self.view addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Auto_Width(17));
            make.top.mas_equalTo(Auto_Width(46)+KTopHeight);
        }];
    }
    return _titleLabel;
}

- (UILabel *)contentLabel
{
    if (!_contentLabel) {
        _contentLabel = [UILabel new];
        _contentLabel.text = @"Please choose the display language you need";
        _contentLabel.numberOfLines = 0;
        _contentLabel.textColor = ColorFromRGB(0xB8B8B8);
        _contentLabel.font = KFont(18);
        [self.view addSubview:_contentLabel];
        [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Auto_Width(17));
            make.top.mas_equalTo(Auto_Width(84)+KTopHeight);
        }];
    }
    return _contentLabel;
}

-(UIButton *)engButton
{
    if (!_engButton) {
        _engButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_engButton addTarget:self action:@selector(clickEngButton) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_engButton];
        [_engButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentLabel.mas_bottom).mas_equalTo(Auto_Width(11));
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(Auto_Width(59));
        }];
        
        UILabel * label = [UILabel new];
        label.text = @"English";
        label.textColor = ColorFromRGB(0xFFFFFF);
        label.font = KFont(15);
        [_engButton addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Auto_Width(15));
            make.centerY.mas_equalTo(0);
        }];
        
        UIImageView * imageView = [[UIImageView alloc] initWithImage:ImageNamed(@"icon_into_arrow")];
        [_engButton addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.right.mas_equalTo(Auto_Width(-15));
            make.size.mas_equalTo(CGSizeMake(Auto_Width(6), Auto_Width(11)));
        }];
        
        UIView * lineView = [UIView new];
        lineView.backgroundColor = ColorFromRGBA(0xFFFFFF, 0.1);
        [_engButton addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Auto_Width(15));
            make.right.mas_equalTo(Auto_Width(-15));
            make.bottom.mas_equalTo(0);
            make.height.mas_equalTo(Auto_Width(1));
        }];
    }
    return _engButton;
}

-(UIButton *)cnButton
{
    if (!_cnButton) {
        _cnButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cnButton addTarget:self action:@selector(clickCnButton) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_cnButton];
        [_cnButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.engButton.mas_bottom);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(Auto_Width(59));
        }];
        
        UILabel * label = [UILabel new];
        label.text = @"中文";
        label.textColor = ColorFromRGB(0xFFFFFF);
        label.font = KFont(15);
        [_cnButton addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Auto_Width(15));
            make.centerY.mas_equalTo(0);
        }];
        
        UIImageView * imageView = [[UIImageView alloc] initWithImage:ImageNamed(@"icon_into_arrow")];
        [_cnButton addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.right.mas_equalTo(Auto_Width(-15));
            make.size.mas_equalTo(CGSizeMake(Auto_Width(6), Auto_Width(11)));
        }];
        
        UIView * lineView = [UIView new];
        lineView.backgroundColor = ColorFromRGBA(0xFFFFFF, 0.1);
        [_cnButton addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Auto_Width(15));
            make.right.mas_equalTo(Auto_Width(-15));
            make.bottom.mas_equalTo(0);
            make.height.mas_equalTo(Auto_Width(1));
        }];
    }
    return _cnButton;
}
@end

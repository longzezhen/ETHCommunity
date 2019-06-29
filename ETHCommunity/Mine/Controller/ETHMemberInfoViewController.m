//
//  ETHMemberInfoViewController.m
//  ETHCommunity
//
//  Created by 龙泽桢 on 2019/6/10.
//  Copyright © 2019 tools. All rights reserved.
//

#import "ETHMemberInfoViewController.h"
#import "ETHMemberInfoButton.h"
@interface ETHMemberInfoViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
//@property (nonatomic,strong)ETHMemberInfoButton * iconButton;
@property (nonatomic,strong)ETHMemberInfoButton * nameButton;
@property (nonatomic,strong)ETHMemberInfoButton * levelButton;
@property (nonatomic,strong)ETHMemberInfoButton * accountButton;
@property (nonatomic,strong)UIButton * logoutButton;

@property (nonatomic,strong)ETHUserBaseInfo * userInfo;
@end

@implementation ETHMemberInfoViewController

#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.userInfo = [MYTools getUserInfo];
    [self initView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

#pragma mark - private
-(void)initView
{
    self.title = L(@"会员信息");
    [self goBackBarButton];
    //self.iconButton.hidden = NO;
    self.nameButton.hidden = NO;
    self.levelButton.hidden = NO;
    self.accountButton.hidden = NO;
    self.logoutButton.hidden = NO;
}


#pragma mark - action
//-(void)clickIconButton
//{
//    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
//    UIAlertAction * cameraAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
//        picker.delegate      = self;
//        picker.sourceType    = UIImagePickerControllerSourceTypeCamera;
//        picker.allowsEditing = YES;
//        [self presentViewController:picker animated:YES completion:nil];
//    }] ;
//
//    UIAlertAction * photoAction = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
//        picker.delegate      = self;
//        picker.sourceType    = UIImagePickerControllerSourceTypePhotoLibrary;
//        picker.allowsEditing = YES;
//        [self presentViewController:picker animated:YES completion:nil];
//    }] ;
//
//    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//
//    }];
//
//    [alertController addAction:cameraAction];
//    [alertController addAction:photoAction];
//    [alertController addAction:cancelAction];
//    [self presentViewController:alertController animated:YES completion:nil];
//}

-(void)clickLogoutButton
{
    UIAlertController * alertC = [UIAlertController alertControllerWithTitle:nil message:L(@"确认退出登录？") preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:L(@"取消") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        //[alertC dismissViewControllerAnimated:YES completion:nil];
    }];
    UIAlertAction * okAction = [UIAlertAction actionWithTitle:L(@"确定") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"token"];
        [AppDelegate startLoginViewController];
    }];
    
    [alertC addAction:cancelAction];
    [alertC addAction:okAction];
    [self presentViewController:alertC animated:YES completion:nil];

}

#pragma mark -  UIImagePickerControllerDelegate
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [picker dismissViewControllerAnimated:YES completion:^{
       
    }];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    [picker dismissViewControllerAnimated:YES completion:^{
        UIImage * pickedImage = info[UIImagePickerControllerEditedImage];
        NSData * imageData = UIImageJPEGRepresentation(pickedImage, 1.0);
        [[BaseNetwork shareNetwork] postFormdataWithPath:URL_ChangeUseInfo token:TOKEN params:@{@"multipartFile":imageData} success:^(NSURLSessionDataTask *task, NSInteger resultCode, id resultObj) {
            if (resultCode == 200) {
                
            }
        } failure:^(NSError *error) {
            
        }];
    }];
}


#pragma mark - get
//-(ETHMemberInfoButton *)iconButton
//{
//    if (!_iconButton) {
//        _iconButton = [[ETHMemberInfoButton alloc] init];
//        _iconButton.leftLabel.text = @"头像";
//        [_iconButton.rightImageView sd_setImageWithURL:[NSURL URLWithString:self.userInfo.headUrl] placeholderImage:ImageNamed(@"icon_ecology_select")];
//        _iconButton.rightLabel.hidden = YES;
////        [_iconButton addTarget:self action:@selector(clickIconButton) forControlEvents:UIControlEventTouchUpInside];
//        [self.view addSubview:_iconButton];
//        [_iconButton mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.left.right.mas_equalTo(0);
//            make.height.mas_equalTo(Auto_Width(59));
//        }];
//    }
//    return _iconButton;
//}

-(ETHMemberInfoButton *)nameButton
{
    if (!_nameButton) {
        _nameButton = [[ETHMemberInfoButton alloc] init];
        _nameButton.leftLabel.text = L(@"姓名");
        _nameButton.rightLabel.text = self.userInfo.nickName;
        _nameButton.rightImageView.hidden = YES;
        [self.view addSubview:_nameButton];
        [_nameButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(0);
            make.height.mas_equalTo(Auto_Width(59));
        }];
    }
    return _nameButton;
}

-(ETHMemberInfoButton *)levelButton
{
    if (!_levelButton) {
        _levelButton = [[ETHMemberInfoButton alloc] init];
        _levelButton.leftLabel.text = L(@"会员等级");
        switch ([self.userInfo.level integerValue]) {
            case 0:
                _levelButton.rightLabel.text = L(@"普通会员");
                break;
            case 1:
                _levelButton.rightLabel.text = L(@"合伙人");
                break;
            case 2:
                _levelButton.rightLabel.text = L(@"开元");
                break;
            case 3:
                _levelButton.rightLabel.text = L(@"创世");
                break;
                
            default:
                break;
        }
        _levelButton.rightImageView.hidden = YES;
        [self.view addSubview:_levelButton];
        [_levelButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(self.nameButton.mas_bottom);
            make.height.mas_equalTo(Auto_Width(59));
        }];
    }
    return _levelButton;
}

-(ETHMemberInfoButton *)accountButton
{
    if (!_accountButton) {
        _accountButton = [[ETHMemberInfoButton alloc] init];
        _accountButton.leftLabel.text = L(@"会员账号");
        _accountButton.rightLabel.text = self.userInfo.username;
        _accountButton.rightImageView.hidden = YES;
        [self.view addSubview:_accountButton];
        [_accountButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(self.levelButton.mas_bottom);
            make.height.mas_equalTo(Auto_Width(59));
        }];
    }
    return _accountButton;
}

-(UIButton *)logoutButton
{
    if (!_logoutButton) {
        _logoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_logoutButton setTitle:L(@"退出登录") forState:UIControlStateNormal];
        [_logoutButton setTitleColor:ColorFromRGB(0xFFFFFF) forState:UIControlStateNormal];
        _logoutButton.titleLabel.font = KFont(15);
        LayerMakeCorner(_logoutButton, Auto_Width(23));
        _logoutButton.backgroundColor = ColorFromRGB(0x2B2D39);
        [_logoutButton addTarget:self action:@selector(clickLogoutButton) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_logoutButton];
        [_logoutButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(self.accountButton.mas_bottom).mas_equalTo(Auto_Width(148));
            make.size.mas_equalTo(CGSizeMake(Auto_Width(320), Auto_Width(45)));
        }];
    }
    return _logoutButton;
}

@end

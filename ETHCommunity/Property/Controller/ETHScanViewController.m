//
//  ETHScanViewController.m
//  ETHCommunity
//
//  Created by 龙泽桢 on 2019/6/11.
//  Copyright © 2019 tools. All rights reserved.
//

#import "ETHScanViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "ETHWalletTransferViewController.h"
@interface ETHScanViewController ()<AVCaptureMetadataOutputObjectsDelegate>
@property (strong,nonatomic)AVCaptureDevice * device;
@property (strong,nonatomic)AVCaptureDeviceInput * input;
@property (strong,nonatomic)AVCaptureMetadataOutput * output;
@property (strong,nonatomic)AVCaptureSession * session;
@property (strong,nonatomic)AVCaptureVideoPreviewLayer * preview;

@property (strong,nonatomic)UIImageView * boxImageView;
@property (strong,nonatomic)UIImageView * lineImageView;
@property (nonatomic,strong)NSTimer * timer;
@end

@implementation ETHScanViewController

#pragma mark - lifeCycle
-(void)dealloc
{
    //永久关闭定时器
    [self.timer invalidate];
    self.timer = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [self.view.layer insertSublayer:self.preview atIndex:0];
    [self.session startRunning];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //开启定时器
    [self.timer setFireDate:[NSDate distantPast]];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //暂停定时器
    [self.timer setFireDate:[NSDate distantFuture]];
}

#pragma mark - private
-(void)initView
{
    self.title = @"二维码扫描";
    self.boxImageView.hidden = NO;
    [self goBackBarButton];
}

#pragma mark - action


#pragma mark - AVCaptureMetadataOutputObjectsDelegate

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    NSString *stringValue;
    if ([metadataObjects count] >0){
        //停止扫描
        [self.session stopRunning];
        //暂停定时器
        [self.timer setFireDate:[NSDate distantFuture]];
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects  objectAtIndex:0];
        stringValue = metadataObject.stringValue;
        
        if ([stringValue hasPrefix:@"store:"]) {
            ETHWalletTransferViewController * vc = [ETHWalletTransferViewController new];
            vc.walletAccount = [stringValue substringFromIndex:6];
            [self.navigationController pushViewController:vc animated:YES];
        }else if ([stringValue hasPrefix:@"club:"]){
            stringValue = [stringValue substringFromIndex:5];
            UIAlertController * alertCon = [UIAlertController alertControllerWithTitle:nil message:@"是否加入当前俱乐部？" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * yesAction = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [[BaseNetwork shareNetwork] postFormurlencodedWithPath:URL_JoinClub token:TOKEN params:@{@"clubCode":stringValue} success:^(NSURLSessionDataTask *task, NSInteger resultCode, id resultObj) {
                    if (resultCode == 200) {
                        [self.view showETHtoast:@"加入成功"];
                    }else{
                        [self.view showETHtoast:@"加入失败"];
                    }
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [self.navigationController popViewControllerAnimated:YES];
                    });
                } failure:^(NSError *error) {
                    [self.view showETHtoast:@"网络错误"];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [self.navigationController popViewControllerAnimated:YES];
                    });
                }];
            }];
            
            UIAlertAction * noAction = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self.navigationController popViewControllerAnimated:YES];
            }];
            [alertCon addAction:noAction];
            [alertCon addAction:yesAction];
            [self presentViewController:alertCon animated:YES completion:nil];
        }else{
            [self.view showETHtoast:@"无效二维码"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        }
        
    }
}

#pragma mark - get
-(AVCaptureDevice *)device
{
    if (!_device) {
        _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    }
    return _device;
}

-(AVCaptureDeviceInput *)input
{
    if (!_input) {
        _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    }
    return _input;
}

-(AVCaptureMetadataOutput *)output
{
    if (!_output) {
        _output = [[AVCaptureMetadataOutput alloc] init];
        [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
        
    }
    return _output;
}

-(AVCaptureSession *)session
{
    if (!_session) {
        _session = [[AVCaptureSession alloc] init];
        [_session setSessionPreset:AVCaptureSessionPresetHigh];
        //连接输入和输入
        if ([_session canAddInput:self.input]) {
            [_session addInput:self.input];
        }
        if ([_session canAddOutput:self.output]) {
            [_session addOutput:self.output];
            //设置条码类型
            self.output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode];
            //view.size
            CGSize size = self.view.bounds.size;
            //boxImageView.frame
            CGRect boxRect = CGRectMake(KScreenWidth/2-Auto_Width(116), Auto_Width(134), Auto_Width(232), Auto_Width(232));
            //设置扫描范围
            self.output.rectOfInterest = CGRectMake(boxRect.origin.y/size.height, boxRect.origin.x/size.width, boxRect.size.height/size.height, boxRect.size.width/size.width);
        }
    }
    return _session;
}

-(AVCaptureVideoPreviewLayer *)preview
{
    if (!_preview) {
        _preview = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
        _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
        _preview.frame = self.view.layer.bounds;
        
    }
    return _preview;
}

-(UIImageView *)boxImageView
{
    if (!_boxImageView) {
        _boxImageView = [[UIImageView alloc] init];
        _boxImageView.image = ImageNamed(@"scan_frame");
        _boxImageView.frame = CGRectMake(KScreenWidth/2-Auto_Width(116), Auto_Width(134), Auto_Width(232), Auto_Width(232));
        [self.view addSubview:_boxImageView];
        
        //10.2.扫描线
        self.lineImageView = [[UIImageView alloc] init];
        self.lineImageView.image = ImageNamed(@"scan_line");
        self.lineImageView.frame = CGRectMake(Auto_Width(15), 0, Auto_Width(202), Auto_Width(4));
        [self.boxImageView addSubview:self.lineImageView];
        
        //创建一个定时器，这种创建方式需要手动将timer放到runloop中
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(moveScanLine) userInfo:nil repeats:YES];
        //开启定时器
        [self.timer setFireDate:[NSDate distantPast]];
    }
    return _boxImageView;
}

-(void)moveScanLine
{
    if (self.lineImageView.frame.origin.y >= self->_boxImageView.frame.size.height) {
        self.lineImageView.frame = CGRectMake(Auto_Width(15), 0, Auto_Width(202), Auto_Width(4));
    }else {
        [self.lineImageView setFrame:CGRectMake(self.lineImageView.frame.origin.x, self.lineImageView.frame.origin.y+1, self.lineImageView.frame.size.width, self.lineImageView.frame.size.height)];
    }
}
@end

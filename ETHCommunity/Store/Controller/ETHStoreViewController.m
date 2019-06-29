//
//  ETHStoreViewController.m
//  ETHCommunity
//
//  Created by 龙泽桢 on 2019/6/4.
//  Copyright © 2019 tools. All rights reserved.
//

#import "ETHStoreViewController.h"
#import "ETHStoreListCell.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "ETHStoreListModel.h"
#import "ETHScanViewController.h"
@interface ETHStoreViewController ()<UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate>
@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)CLLocationManager * locationManager;
@property (nonatomic,strong)NSMutableArray * storeListArray;
@end

@implementation ETHStoreViewController
-(void)dealloc
{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // 开始时时定位
    if ([CLLocationManager locationServicesEnabled])
    {
        // 开启位置更新需要与服务器进行轮询所以会比较耗电，在不需要时用stopUpdatingLocation方法关闭;
        [self.locationManager startUpdatingLocation];
    }else
    {
        [self.view showETHtoast:@"请开启定位功能"];
    }
}

#pragma mark - private
-(void)initView
{
    self.title = L(@"商城");
    UIImage * rightImage = [ImageNamed(@"icon_scan") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithImage:rightImage style:UIBarButtonItemStylePlain target:self action:@selector(clickRightButton)];
    self.navigationItem.rightBarButtonItem = rightItem;
    self.tableView.hidden = NO;
}

-(void)loadViewDataWithLongitude:(NSString*)longitude andLatitude:(NSString*)latitude
{
    [[BaseNetwork shareNetwork] postFormurlencodedWithPath:URL_StoreList token:TOKEN params:@{@"latitude":latitude,@"longitude":longitude,@"page":@"1",@"size":@"100"} success:^(NSURLSessionDataTask *task, NSInteger resultCode, id resultObj) {
        if (resultCode == 200) {
            NSArray * dicArray = resultObj[@"data"][@"list"];
            self.storeListArray = [ETHStoreListModel mj_objectArrayWithKeyValuesArray:dicArray];
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        [self.view showETHtoast:@"网络错误"];
    }];
}

//获取手机安装的地图
- (NSArray *)getInstalledMapAppWithEndLocation:(CLLocationCoordinate2D)endLocation
{
    NSMutableArray *maps = [NSMutableArray array];
    
    //苹果地图
    NSMutableDictionary *iosMapDic = [NSMutableDictionary dictionary];
    iosMapDic[@"title"] = @"苹果地图";
    [maps addObject:iosMapDic];
    
    //百度地图
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]]) {
        NSMutableDictionary *baiduMapDic = [NSMutableDictionary dictionary];
        baiduMapDic[@"title"] = @"百度地图";
        NSString *urlString = [[NSString stringWithFormat:@"baidumap://map/direction?origin={{我的位置}}&destination=latlng:%f,%f|name=北京&mode=driving&coord_type=gcj02",endLocation.latitude,endLocation.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        baiduMapDic[@"url"] = urlString;
        [maps addObject:baiduMapDic];
    }
    
    //高德地图
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]]) {
        NSMutableDictionary *gaodeMapDic = [NSMutableDictionary dictionary];
        gaodeMapDic[@"title"] = @"高德地图";
        NSString *urlString = [[NSString stringWithFormat:@"iosamap://navi?sourceApplication=%@&backScheme=%@&lat=%f&lon=%f&dev=0&style=2",@"导航功能",@"nav123456",endLocation.latitude,endLocation.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        gaodeMapDic[@"url"] = urlString;
        [maps addObject:gaodeMapDic];
    }
    
    //谷歌地图
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"comgooglemaps://"]]) {
        NSMutableDictionary *googleMapDic = [NSMutableDictionary dictionary];
        googleMapDic[@"title"] = @"谷歌地图";
        NSString *urlString = [[NSString stringWithFormat:@"comgooglemaps://?x-source=%@&x-success=%@&saddr=&daddr=%f,%f&directionsmode=driving",@"导航测试",@"nav123456",endLocation.latitude, endLocation.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        googleMapDic[@"url"] = urlString;
        [maps addObject:googleMapDic];
    }
    
    //腾讯地图
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"qqmap://"]]) {
        NSMutableDictionary *qqMapDic = [NSMutableDictionary dictionary];
        qqMapDic[@"title"] = @"腾讯地图";
        NSString *urlString = [[NSString stringWithFormat:@"qqmap://map/routeplan?from=我的位置&type=drive&tocoord=%f,%f&to=终点&coord_type=1&policy=0",endLocation.latitude, endLocation.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        qqMapDic[@"url"] = urlString;
        [maps addObject:qqMapDic];
    }
    
    return maps;
}

#pragma mark - action
-(void)clickRightButton
{
    ETHScanViewController * vc = [ETHScanViewController new];
    [BaseNavViewController pushViewController:vc hiddenBottomWhenPush:YES animation:YES fromNavigation:self.navigationController];
}

#pragma mark - UITableViewDelegate/UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.storeListArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ETHStoreListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"STORECELL"];
    cell.model = self.storeListArray[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ETHStoreListModel * model = self.storeListArray[indexPath.row];
    CLLocationCoordinate2D endLocation = {[model.latitude floatValue],[model.longitude floatValue]};
    NSArray * mapArray = [self getInstalledMapAppWithEndLocation:endLocation];
    
    UIAlertController * mapController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    for (int i = 0; i<mapArray.count; i++) {
        NSMutableDictionary * dic = mapArray[i];
        if (i == 0) {
            UIAlertAction * appleAction = [UIAlertAction actionWithTitle:dic[@"title"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //CLLocationCoordinate2D gps = [JZLocationConverter bd09ToWgs84:self.destinationCoordinate2D];
                
                MKMapItem *currentLoc = [MKMapItem mapItemForCurrentLocation];
                MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:endLocation addressDictionary:nil]];
                NSArray *items = @[currentLoc,toLocation];
                NSDictionary *dic = @{
                                      MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving,
                                      MKLaunchOptionsMapTypeKey : @(MKMapTypeStandard),
                                      MKLaunchOptionsShowsTrafficKey : @(YES)
                                      };
                
                [MKMapItem openMapsWithItems:items launchOptions:dic];
            }];
            
            [mapController addAction:appleAction];
        }else{
            UIAlertAction * action = [UIAlertAction actionWithTitle:dic[@"title"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:dic[@"url"]]];
            }];
            [mapController addAction:action];
        }
    }
    
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:L(@"取消") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [mapController addAction:cancelAction];
    
    [self presentViewController:mapController animated:YES completion:nil];
}

#pragma mark - CLLocationManagerDelegate
//开启定位后会先调用此方法，判断有没有权限
-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    
}

//成功获取到经纬度
-(void)locationManager:(nonnull CLLocationManager *)manager didUpdateLocations:(nonnull NSArray<CLLocation *> *)locations
{
    CLLocation *location = locations.lastObject;
    NSString * longitudeStr = [NSString stringWithFormat:@"%f",location.coordinate.longitude];
    NSString * latitudeStr = [NSString stringWithFormat:@"%f",location.coordinate.latitude];
    [self loadViewDataWithLongitude:longitudeStr andLatitude:latitudeStr];
    // 停止位置更新
    [manager stopUpdatingLocation];
}

// 定位失败错误信息
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"error");
}

#pragma mark - get
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [UITableView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[ETHStoreListCell class] forCellReuseIdentifier:@"STORECELL"];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }
    return _tableView;
}

-(CLLocationManager *)locationManager
{
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        // 设置定位精度，十米，百米，最好
        _locationManager.desiredAccuracy=kCLLocationAccuracyBest;
        //每隔多少米定位一次（这里的设置为任何的移动）
        _locationManager.distanceFilter = kCLDistanceFilterNone;
        _locationManager.delegate = self; //代理设置
        [_locationManager requestAlwaysAuthorization];
        _locationManager.distanceFilter = 10.0f;
        [_locationManager requestWhenInUseAuthorization];
    }
    return _locationManager;
}
@end

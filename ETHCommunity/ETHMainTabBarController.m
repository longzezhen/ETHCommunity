//
//  ETHMainTabBarController.m
//  ETHCommunity
//
//  Created by 龙泽桢 on 2019/6/4.
//  Copyright © 2019 tools. All rights reserved.
//

#import "ETHMainTabBarController.h"
#import "ETHPropertyViewController.h"
#import "ETHEcologicalViewController.h"
#import "ETHStoreViewController.h"
#import "ETHMineViewController.h"
@interface ETHMainTabBarController ()
@property (nonatomic,strong) BaseNavViewController * propertyNav;
@property (nonatomic,strong) BaseNavViewController * ecologicalNav;
@property (nonatomic,strong) BaseNavViewController * storeNav;
@property (nonatomic,strong) BaseNavViewController * mineNav;
@end

@implementation ETHMainTabBarController
#pragma mark - lifeCycle
-(void)dealloc
{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.barStyle = UIBarStyleBlack;
    self.viewControllers = @[self.propertyNav,self.ecologicalNav,self.storeNav,self.mineNav];
}

#pragma mark - private
-(void)setItemWithVC:(UIViewController *)vc title:(NSString *)title normalImage:(NSString *)normalImage selectedImage:(NSString *)selectedImage idx:(NSUInteger)idx
{
    if (normalImage) {
        UIImage *noImage = [UIImage imageNamed:normalImage];
        noImage = [noImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        vc.tabBarItem = [[UITabBarItem alloc]initWithTitle:title image:noImage tag:idx];
    }
    
    if (selectedImage) {
        UIImage *seImage = [UIImage imageNamed:selectedImage];
        seImage = [seImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [vc.tabBarItem setSelectedImage:seImage];
    }
    
    [vc.tabBarItem  setTitleTextAttributes:@{NSForegroundColorAttributeName:ColorFromRGB(0xB8B8B8)}
                                  forState:UIControlStateNormal];
    [vc.tabBarItem  setTitleTextAttributes:@{NSForegroundColorAttributeName:ColorFromRGB(0xD8A85E)}
                                  forState:UIControlStateSelected];
}


#pragma mark - get
-(BaseNavViewController *)propertyNav
{
    if (!_propertyNav) {
        ETHPropertyViewController * vc = [[ETHPropertyViewController alloc] init];
        [self setItemWithVC:vc title:L(@"资产") normalImage:@"icon_property_normal" selectedImage:@"icon_property_select" idx:1];
        
        _propertyNav = [[BaseNavViewController alloc] initWithRootViewController:vc];
    }
    return _propertyNav;
}

-(BaseNavViewController *)ecologicalNav
{
    if (!_ecologicalNav) {
        ETHEcologicalViewController * vc = [[ETHEcologicalViewController alloc] init];
        [self setItemWithVC:vc title:L(@"生态") normalImage:@"icon_ecology_normal" selectedImage:@"icon_ecology_select" idx:2];
        
        _ecologicalNav = [[BaseNavViewController alloc] initWithRootViewController:vc];
    }
    return _ecologicalNav;
}

-(BaseNavViewController *)storeNav
{
    if (!_storeNav) {
        ETHStoreViewController * vc = [[ETHStoreViewController alloc] init];
        [self setItemWithVC:vc title:L(@"生态") normalImage:@"icon_store_normal" selectedImage:@"icon_store_select" idx:3];
        
        _storeNav = [[BaseNavViewController alloc] initWithRootViewController:vc];
    }
    return _storeNav;
}

-(BaseNavViewController *)mineNav
{
    if (!_mineNav) {
        ETHMineViewController * vc = [[ETHMineViewController alloc] init];
        [self setItemWithVC:vc title:L(@"生态") normalImage:@"icon_mine_normal" selectedImage:@"icon_mine_select" idx:4];
        
        _mineNav = [[BaseNavViewController alloc] initWithRootViewController:vc];
    }
    return _mineNav;
}
@end

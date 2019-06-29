//
//  ETHEcologicalViewController.m
//  ETHCommunity
//
//  Created by 龙泽桢 on 2019/6/4.
//  Copyright © 2019 tools. All rights reserved.
//

#import "ETHEcologicalViewController.h"
#import "ETHEcologicalListCell.h"
#import "ETHWalletETIViewController.h"
#import "ETHWalletETITViewController.h"
@interface ETHEcologicalViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView * tableView;

@property (nonatomic,strong)UILabel * earnLabel;
@property (nonatomic,strong)NSArray * dataArray;
@end

@implementation ETHEcologicalViewController
#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getUserPropertyInfo];
    
}

#pragma mark - private
-(void)initView
{
    self.title = L(@"生态");
    self.tableView.hidden = NO;
    
}

-(void)getUserPropertyInfo
{
    [[BaseNetwork shareNetwork] postFormurlencodedWithPath:URL_PropertyInfo token:TOKEN params:nil success:^(NSURLSessionDataTask *task, NSInteger resultCode, id resultObj) {
        if (resultCode == 200) {
            self.earnLabel.text = [NSString stringWithFormat:@"%@%@",L(@"累计量化收益："),resultObj[@"data"][@"yestodayEarningStr"]];
            NSArray * listArray = resultObj[@"data"][@"list"];
            if (listArray.count>=3) {
                NSDictionary * ETIDic = listArray[1];
                NSDictionary * ETITDic = listArray[2];
                NSIndexPath * path1 = [NSIndexPath indexPathForRow:0 inSection:0];
                ETHEcologicalListCell * ETICell = [self.tableView cellForRowAtIndexPath:path1];
                ETICell.subTitleLabel.text = [NSString stringWithFormat:@"%@%@",L(@"总币数："),ETIDic[@"amountStr"]];
                NSIndexPath * path2 = [NSIndexPath indexPathForRow:1 inSection:0];
                ETHEcologicalListCell * ETITCell = [self.tableView cellForRowAtIndexPath:path2];
                ETITCell.subTitleLabel.text = [NSString stringWithFormat:@"%@%@",L(@"总币数："),ETITDic[@"amountStr"]];
            }
        }
    } failure:^(NSError *error) {
    }];
}

#pragma mark - 解决sectionHeaderView悬浮问题
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.tableView)
    {
        CGFloat sectionHeaderHeight = Auto_Width(30);//此高度为heightForHeaderInSection高度值
        if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        }
    }
}

#pragma mark - UITableViewDelegate/UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ETHEcologicalListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ECOLOGICALLISTCELL"];
    cell.dataDic = self.dataArray[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return Auto_Width(105);
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, Auto_Width(30))];
    self.earnLabel = [UILabel new];
    self.earnLabel.text = [NSString stringWithFormat:@"%@",L(@"累计量化收益：")];
    self.earnLabel.textColor = ColorFromRGB(0xFFFFFF);
    self.earnLabel.font = KFont(13);
    [view addSubview:self.earnLabel];
    [self.earnLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.left.mas_equalTo(Auto_Width(36));
    }];
    return view;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        ETHWalletETIViewController * vc = [ETHWalletETIViewController new];
        [BaseNavViewController pushViewController:vc hiddenBottomWhenPush:YES animation:YES fromNavigation:self.navigationController];
    }else if (indexPath.row == 1){
        ETHWalletETITViewController * vc = [ETHWalletETITViewController new];
        [BaseNavViewController pushViewController:vc hiddenBottomWhenPush:YES animation:YES fromNavigation:self.navigationController];
    }else{
        [self.view showETHtoast:L(@"正在开发中")];
    }
    
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
        [_tableView registerClass:[ETHEcologicalListCell class] forCellReuseIdentifier:@"ECOLOGICALLISTCELL"];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        
        UIView * tableHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, Auto_Width(126))];
        UIImageView * imageView = [[UIImageView alloc] initWithImage:ImageNamed(@"ecological_banner")];
        [tableHeadView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Auto_Width(17));
            make.right.mas_equalTo(Auto_Width(-17));
            make.bottom.mas_equalTo(0);
            make.top.mas_equalTo(Auto_Width(6));
        }];
        
        _tableView.tableHeaderView = tableHeadView;
    }
    return _tableView;
}

-(NSArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = @[@{@"imageName":@"img_financial_package",@"title":L(@"量化交易理财包"),@"subTitle":L(@"总币数：")},@{@"imageName":@"img_caf_mining",@"title":L(@"ETIT挖矿"),@"subTitle":L(@"总币数：")},@{@"imageName":@"img_foreign_exchange",@"title":L(@"外汇"),@"subTitle":L(@"世界行情，近在眼前")},@{@"imageName":@"img_entertainment",@"title":L(@"娱乐"),@"subTitle":L(@"生活如此精彩")},@{@"imageName":@"img_movies",@"title":L(@"影视"),@"subTitle":L(@"精彩大片等你来")},@{@"imageName":@"img_loan",@"title":L(@"借贷"),@"subTitle":L(@"3秒到账，就是快")}];
    }
    return _dataArray;
}
@end

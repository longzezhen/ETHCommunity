//
//  ETHPropertyViewController.m
//  ETHCommunity
//
//  Created by 龙泽桢 on 2019/6/4.
//  Copyright © 2019 tools. All rights reserved.
//

#import "ETHPropertyViewController.h"
#import "ETHWalletListCell.h"
#import "ETHPriceListCell.h"
#import "ETHAnnouncementViewController.h"
#import "ETHWalletETHViewController.h"
#import "ETHWalletETIViewController.h"
#import "ETHWalletETITViewController.h"
#import "ETHScanRegisterViewController.h"
#import "ETHScanViewController.h"
#import "LYHWebSocketManager.h"
@interface ETHPropertyViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)UIView * tableHeadView;
@property (nonatomic,strong)UILabel * totalMoneyLabel;
@property (nonatomic,strong)UILabel * lastDayEarnLabel;
@property (nonatomic,strong)UIView * firstSectionView;
@property (nonatomic,strong)UILabel * noticeLabel;

@property (nonatomic,strong)NSMutableArray * walletValueMutableArray;
@property (nonatomic,strong)NSMutableArray * coinQuoteArray;
@end

@implementation ETHPropertyViewController

#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[LYHWebSocketManager sharedInstance] connect];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveMessage:) name:@"SRPriceMessage" object:nil];
    [self getNoticeListInfo];
    [self getUserPropertyInfo];
    [self getCoinQuoteList];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[LYHWebSocketManager sharedInstance] close];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"SRPriceMessage" object:nil];
}

#pragma mark - private
-(void)initView
{
    self.navigationItem.title = @"ETH";
    UIImage * leftImage = [ImageNamed(@"icon_qrcode") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithImage:leftImage style:UIBarButtonItemStylePlain target:self action:@selector(clickLeftButton)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIImage * rightImage = [ImageNamed(@"icon_scan") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithImage:rightImage style:UIBarButtonItemStylePlain target:self action:@selector(clickRightButton)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    self.tableView.hidden = NO;
}

-(void)getNoticeListInfo
{
    [[BaseNetwork shareNetwork] postFormurlencodedWithPath:URL_GetNotice token:TOKEN params:@{@"page":@"1",@"size":@"1"} success:^(NSURLSessionDataTask *task, NSInteger resultCode, id resultObj) {
        if (resultCode == 200) {
            NSArray * array = resultObj[@"data"][@"list"];
            NSDictionary * dic = array[0];
            self.noticeLabel.text = [NSString stringWithFormat:@"%@：%@",L(@"公告"),dic[@"title"]];
        }else
        {
            
        }
    } failure:^(NSError *error) {
        
    }];
}

-(void)getUserPropertyInfo
{
    [[BaseNetwork shareNetwork] postFormurlencodedWithPath:URL_PropertyInfo token:TOKEN params:nil success:^(NSURLSessionDataTask *task, NSInteger resultCode, id resultObj) {
        if (resultCode == 200) {
            self.totalMoneyLabel.text = resultObj[@"data"][@"totalAmountStr"];
            self.lastDayEarnLabel.text = [NSString stringWithFormat:@"%@%@",L(@"昨日收益："),resultObj[@"data"][@"yestodayEarningStr"]];
            NSArray * listArray = resultObj[@"data"][@"list"];
            for (NSDictionary * dic in listArray) {
                [self.walletValueMutableArray addObject:dic[@"amountStr"]];
            }
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
    }];
}

-(void)getCoinQuoteList
{
    [[BaseNetwork shareNetwork] postFormurlencodedWithPath:URL_CoinQuoteList token:TOKEN params:nil success:^(NSURLSessionDataTask *task, NSInteger resultCode, id resultObj) {
        if (resultCode == 200) {
            [self.coinQuoteArray removeAllObjects];
            NSArray * dataArray = resultObj[@"data"];
            for (NSDictionary* dic in dataArray) {
                if ([dic[@"symbol"] isEqualToString:@"ETH"]) {
                    [self.coinQuoteArray addObject:dic];
                    break;
                }
            }
            for (NSDictionary* dic in dataArray) {
                if ([dic[@"symbol"] isEqualToString:@"ETIT"]) {
                    [self.coinQuoteArray addObject:dic];
                    break;
                }
            }
            for (NSDictionary* dic in dataArray) {
                if ([dic[@"symbol"] isEqualToString:@"EOS"]) {
                    [self.coinQuoteArray addObject:dic];
                    break;
                }
            }
            for (NSDictionary* dic in dataArray) {
                if ([dic[@"symbol"] isEqualToString:@"BCH"]) {
                    [self.coinQuoteArray addObject:dic];
                    break;
                }
            }
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - action
-(void)receiveMessage:(NSNotification *)noti
{
    NSArray * array = noti.object;
    //NSLog(@"array:%@",array);
    if (array) {
        self.coinQuoteArray = [NSMutableArray arrayWithArray:array];
        [self.tableView reloadData];
    }
}

-(void)clickLeftButton
{
    ETHScanRegisterViewController * vc = [ETHScanRegisterViewController new];
    [BaseNavViewController pushViewController:vc hiddenBottomWhenPush:YES animation:YES fromNavigation:self.navigationController];
}

-(void)clickRightButton
{
    ETHScanViewController * vc = [ETHScanViewController new];
    [BaseNavViewController pushViewController:vc hiddenBottomWhenPush:YES animation:YES fromNavigation:self.navigationController];
}

-(void)clickFirstSectionView
{
    ETHAnnouncementViewController * vc = [ETHAnnouncementViewController new];
    [BaseNavViewController pushViewController:vc hiddenBottomWhenPush:YES animation:YES fromNavigation:self.navigationController];
}

#pragma mark - 解决sectionHeaderView悬浮问题
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.tableView)
    {
        CGFloat sectionHeaderHeight = 40;//此高度为heightForHeaderInSection高度值
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
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 3;
    }else{
        return self.coinQuoteArray.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        ETHWalletListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"WALLETCELL"];
        
        switch (indexPath.row) {
            case 0:
                cell.iconImageView.image = ImageNamed(@"eth_wallet");
                cell.titleLabel.text = @"ETH-Wallet";
                break;
            case 1:
                cell.iconImageView.image = ImageNamed(@"eti_wallet");
                cell.titleLabel.text = @"ETI-Wallet";
                break;
            case 2:
                cell.iconImageView.image = ImageNamed(@"caf_wallet");
                cell.titleLabel.text = @"ETIT-Wallet";
                break;
                
            default:
                break;
        }
        if (self.walletValueMutableArray.count == 3) {
            cell.bottomLabel.text = [NSString stringWithFormat:@"%@",self.walletValueMutableArray[indexPath.row]];
        }
        return cell;
    }else{
        ETHPriceListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"PRICECELL"];
        cell.dic = self.coinQuoteArray[indexPath.row];
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
            {
                ETHWalletETHViewController * vc = [ETHWalletETHViewController new];
                [BaseNavViewController pushViewController:vc hiddenBottomWhenPush:YES animation:YES fromNavigation:self.navigationController];
            }
                break;
            case 1:
            {
                ETHWalletETIViewController * vc = [ETHWalletETIViewController new];
                [BaseNavViewController pushViewController:vc hiddenBottomWhenPush:YES animation:YES fromNavigation:self.navigationController];
            }
                break;
            case 2:
            {
                ETHWalletETITViewController * vc = [ETHWalletETITViewController new];
                [BaseNavViewController pushViewController:vc hiddenBottomWhenPush:YES animation:YES fromNavigation:self.navigationController];
            }
                break;
                
            default:
                break;
        }
    }else{
        switch (indexPath.row) {
            case 0:
                
                break;
            case 1:
                
                break;
            case 2:
                
                break;
            case 3:
                
                break;
                
            default:
                break;
        }
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return self.firstSectionView;
    }else{
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, Auto_Width(35))];
        UIView * lineView = [UIView new];
        lineView.backgroundColor = ColorFromRGB(0xD8A85E);
        [view addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(Auto_Width(20));
            make.left.mas_equalTo(Auto_Width(15));
            make.size.mas_equalTo(CGSizeMake(Auto_Width(2), Auto_Width(14)));
        }];
        UILabel * label = [UILabel new];
        label.text = L(@"行情");
        label.textColor = ColorFromRGB(0xFFFFFF);
        label.font = KFont(14);
        [view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(lineView);
            make.left.mas_equalTo(lineView.mas_right).mas_equalTo(Auto_Width(5));
        }];
        
        UIView * priceView = [UIView new];
        priceView.backgroundColor = ColorFromRGBA(0xFFFFFF, 0.0549);
        [view addSubview:priceView];
        [priceView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Auto_Width(15));
            make.right.mas_equalTo(Auto_Width(-15));
            make.bottom.mas_equalTo(0);
            make.top.mas_equalTo(label.mas_bottom).mas_equalTo(Auto_Width(13));
        }];
        
        UILabel * bzLabel = [UILabel new];
        bzLabel.text = L(@"币种");
        bzLabel.textColor = ColorFromRGB(0xD8D8D8);
        bzLabel.font = KFont(13);
        [priceView addSubview:bzLabel];
        [bzLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.left.mas_equalTo(Auto_Width(16));
        }];
        
        UILabel * zxjkLabel = [UILabel new];
        zxjkLabel.text = L(@"最新价");
        zxjkLabel.textColor = ColorFromRGB(0xD8D8D8);
        zxjkLabel.font = KFont(13);
        [priceView addSubview:zxjkLabel];
        [zxjkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(0);
        }];
        
        UILabel * zdfkLabel = [UILabel new];
        zdfkLabel.text = L(@"涨跌幅");
        zdfkLabel.textColor = ColorFromRGB(0xD8D8D8);
        zdfkLabel.font = KFont(13);
        [priceView addSubview:zdfkLabel];
        [zdfkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.right.mas_equalTo(Auto_Width(-16));
        }];
        UIView * bottomLineView = [UIView new];
        bottomLineView.backgroundColor = ColorFromRGBA(0xF4F4F4, 0.0453);
        [priceView addSubview:bottomLineView];
        [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.height.mas_equalTo(Auto_Width(2));
        }];
        
        return view;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return Auto_Width(35);
    }else{
        return Auto_Width(80);
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return Auto_Width(100);
    }else{
        return Auto_Width(45);
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
        _tableView.tableHeaderView = self.tableHeadView;
        UIView * footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, Auto_Width(25))];
        footView.backgroundColor = [UIColor clearColor];
        _tableView.tableFooterView = footView;
        [_tableView registerClass:[ETHWalletListCell class] forCellReuseIdentifier:@"WALLETCELL"];
        [_tableView registerClass:[ETHPriceListCell class] forCellReuseIdentifier:@"PRICECELL"];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }
    return _tableView;
}

-(UIView *)tableHeadView
{
    if (!_tableHeadView) {
        _tableHeadView = [UIView new];
        _tableHeadView.frame = CGRectMake(0, 0, KScreenWidth, Auto_Width(165));
        
        UIImageView * backImageView = [[UIImageView alloc] initWithImage:ImageNamed(@"bg_eth_money")];
        [_tableHeadView addSubview:backImageView];
        [backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.mas_equalTo(Auto_Width(15));
            make.right.bottom.mas_equalTo(Auto_Width(-15));
        }];
        
        self.totalMoneyLabel = [UILabel new];
        self.totalMoneyLabel.text = @"0.00";
        self.totalMoneyLabel.textColor = ColorFromRGB(0xFFFFFF);
        self.totalMoneyLabel.font = KFont(36);
        [backImageView addSubview:self.totalMoneyLabel];
        [self.totalMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(0);
        }];
        UILabel * label1 = [UILabel new];
        label1.text = L(@"总资产（¥）");
        label1.textColor = ColorFromRGB(0xFFFFFF);
        label1.font = KFont(14);
        [backImageView addSubview:label1];
        [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.bottom.mas_equalTo(self.totalMoneyLabel.mas_top).mas_equalTo(Auto_Width(-10));
        }];
        
        self.lastDayEarnLabel = [UILabel new];
        self.lastDayEarnLabel.text = @"昨日收益：1.68元";
        self.lastDayEarnLabel.textColor = ColorFromRGB(0xFFFFFF);
        self.lastDayEarnLabel.font = KFont(11);
        [backImageView addSubview:self.lastDayEarnLabel];
        [self.lastDayEarnLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(self.totalMoneyLabel.mas_bottom).mas_equalTo(Auto_Width(20));
        }];
    }
    return _tableHeadView;
}

-(UIView *)firstSectionView
{
    if (!_firstSectionView) {
        _firstSectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, Auto_Width(35))];
        UIImageView * noticeImageView = [[UIImageView alloc] initWithImage:ImageNamed(@"icon_notice")];
        [_firstSectionView addSubview:noticeImageView];
        [noticeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.left.mas_equalTo(Auto_Width(15));
            make.size.mas_equalTo(CGSizeMake(Auto_Width(18), Auto_Width(14)));
        }];
        
        self.noticeLabel = [UILabel new];
        self.noticeLabel.text = @"公告：*****";
        self.noticeLabel.textColor = ColorFromRGB(0xFFFFFF);
        self.noticeLabel.font = KFont(12);
        [_firstSectionView addSubview:self.noticeLabel];
        [self.noticeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.left.mas_equalTo(noticeImageView.mas_right).mas_equalTo(Auto_Width(12));
        }];
        
        UITapGestureRecognizer * tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickFirstSectionView)];
        [_firstSectionView addGestureRecognizer:tapGR];
    }
    return _firstSectionView;
}

-(NSMutableArray *)walletValueMutableArray
{
    if (!_walletValueMutableArray) {
        _walletValueMutableArray = [NSMutableArray array];
    }
    return _walletValueMutableArray;
}

-(NSMutableArray *)coinQuoteArray
{
    if (!_coinQuoteArray) {
        _coinQuoteArray = [NSMutableArray array];
    }
    return _coinQuoteArray;
}
@end

//
//  HttpUrlHeader.h
//  ThreeSandOcean
//
//  Created by 龙泽桢 on 2019/5/27.
//  Copyright © 2019 tools. All rights reserved.
//


#define URL_base    @"http://52.198.245.251:8080" //服务器地址+端口


/*** 注册 ***/
#define URL_userRegister                        URL_base@"/api/mine/register"
/*** 账号密码登录 **/
#define URL_userLogin                           URL_base@"/api/mine/username/login"
/*** 助记词登录 **/
#define URL_ZJCLogin                            URL_base@"/api/mine/words/login"
/*** 修改用户信息 **/
#define URL_ChangeUseInfo                       URL_base@"/api/mine/user/edit"
/*** 获取商城门店列表 ***/
#define URL_StoreList                           URL_base@"/api/mall/caf_record/list_with_page"
/*** 获取用户资产基本信息 ***/
#define URL_PropertyInfo                        URL_base@"/api/asset/info"
/*** 获取所有币的行情列表 ***/
#define URL_CoinQuoteList                           URL_base@"/api/asset/quote/list"
/*** 加入俱乐部 ***/
#define URL_JoinClub                             URL_base@"/api/asset/join_club"
/*** 用户信息 ***/
#define URL_UserInfo                            URL_base@"/api/mine/user_info"
/*** 获取公告列表 ***/
#define URL_GetNotice                            URL_base@"/api/asset/announcement/list_with_page"

//#ifndef HttpUrlHeader_h
//#define HttpUrlHeader_h
//
//
//#endif /* HttpUrlHeader_h */

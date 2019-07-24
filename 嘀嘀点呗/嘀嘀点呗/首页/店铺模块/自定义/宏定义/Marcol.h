//
//  Marcol.h
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/1/8.
//  Copyright © 2018年 xgy. All rights reserved.
//

#ifndef Marcol_h
#define Marcol_h


#endif /* Marcol_h */

#import "NSString+PJR.h"
#import "GoodsListManager.h"
#import "GoodShopManagement.h"
#define MenuHeight 40

#define TR_Alpha 0.5

#define HeadViewHeight 210

#define ORDERTYPE @"IS_ORDERFROMOSAVEDB"

static NSString *const adImageName = @"adImageName";

#define GRAYCLOLOR  TR_COLOR_RGBACOLOR_A(239, 239, 239, 1)


#define ORANGECOLOR TR_COLOR_RGBACOLOR_A(255, 144, 56, 1)


#define GRAY_Text_COLOR  TR_COLOR_RGBACOLOR_A(85, 85, 85, 1)

#define LITTLEGRAY  TR_COLOR_RGBACOLOR_A(231, 232, 231, 1)

#pragma 获取设备ID
#define DeviceID  [[[UIDevice currentDevice] identifierForVendor] UUIDString]


//#define SERVER_NEWVC  @"http://118.31.11.208/appapi.php"
//#define SERVER_NEWVC  @"https://www.dianbeiwaimai.cn/appapi.php"

#define SERVER_NEWURL(url,c,a)     [NSString stringWithFormat:@"%@?c=%@&a=%@",url,c,a]

#pragma 个人中心模块
#define PERSONAL_VERIFITION  SERVER_URL(SERVER_MC,@"Login_new",@"sendCode") //个人中心 验证码



#define SHOP_ADVER SERVER_URL(SERVER_MC,@"Shop_new",@"start_up_Adver") //首页广告

//微信登录成功后绑定用户信息

#define PERSONAL_BULDUSERMESSAGE SERVER_URL(SERVER_MC,@"Login_new",@"weixin_login")


#define PERSONAL_BULDWX SERVER_URL(SERVER_MC,@"Login_new",@"bind_weixin")

//验证原手机号码
#define PERSONAL_ORIALPHONE  SERVER_URL(SERVER_MC,@"Login_new",@"verifyCode")

//微信绑定新手机
#define PERSONAL_NEWPHONE  SERVER_URL(SERVER_MC,@"Login_new",@"bind_user")


//绑定新手机
#define PERSONAL_NEWPHONE2  SERVER_URL(SERVER_MC,@"Login_new",@"modify_phone")

#define PERSONAL_LOGIN  SERVER_URL(SERVER_MC,@"Login_new",@"login") //个人中心 验证码


#define PERSONAL_ADRESS  SERVER_URL(SERVER_MC,@"My_new",@"adress")  //个人中心 我的地址

#define PERSONAL_ADRESS_SHOW  SERVER_URL(SERVER_MC,@"My",@"adress_show") //个人中心 编辑已经有的我的地址
#define PERSONAL_EDIT_ADRESS  SERVER_URL(SERVER_MC,@"My_new",@"edit_adress") //个人中心 编辑我的地址保存   新增地址保存
#define PERSONAL_DELADRESS  SERVER_URL(SERVER_MC,@"My_new",@"del_adress") //个人中心 删除我的地址
#define PERSONAL_COMMENT_LIST SERVER_URL(SERVER_MC,@"My_new",@"comment_list")  // 个人中心 我的评论


#define PERSONAL_REDBAO_LIST SERVER_URL(SERVER_MC,@"My_new",@"my_coupon_list")  // 个人中心 红包列表

#define PERSONAL_SHOP_DISCOUNT SERVER_URL(SERVER_MC,@"My_new",@"my_voucher_list")  // 个人中心 商家代金券

#define SHOP_STORECOMMENT_LIST SERVER_URL(SERVER_MC,@"Shop_new",@"ajax_reply")  // 商家评论


//评价晒单
#define ORDER_COMMENTORDER SERVER_URL(SERVER_MC,@"My_new",@"add_comment")

#define SHOP_STORESAVE SERVER_URL(SERVER_MC,@"Shop_new",@"user_Collectionstore")  // 店铺收藏和取消


//新增用户接口

#define PERSONAL_MESSAGE SERVER_NEWURL(SERVER_MC,@"My_new",@"my")


//意见反馈接口

#define PERSONAL_SUGGESS SERVER_NEWURL(SERVER_MC,@"My_new",@"feedback")


//上传用户头像图片

#define PERSONAL_AVATAR SERVER_NEWURL(SERVER_MC,@"My_new",@"upload_avatar")

//评论晒单上传图片
#define ORDERCOMMENR_AVATAR SERVER_NEWURL(SERVER_MC,@"My_new",@"pic_comment")

//修改昵称

#define PERSONAL_NICNAME SERVER_NEWURL(SERVER_MC,@"My_dd",@"username")

//解绑微信

#define PERSONAL_DELETEWEIXIN SERVER_NEWURL(SERVER_MC,@"My_new",@"relieve_weixin")

//收藏店铺列表
#define PERSONAL_SAVESHOP SERVER_NEWURL(SERVER_MC,@"Shop_new",@"collection")

//店铺内搜索
#define SHOP_SEARCHGOODS    SERVER_URL(SERVER_MC,@"Shop_dd",@"Shop_search")

#define SHOP_NEWAJAXSHOP SERVER_URL(SERVER_MC,@"Shop_new",@"ajax_shop") //店铺信息／菜品列表

#define SHOP_RESERVESITE SERVER_URL(SERVER_MC,@"My_new",@"adress") //结算界面收货地址


//提交订单

#define SHOP_REPORTORDER SERVER_URL(SERVER_MC,@"Shop_new",@"ajax_cart")


//保存订单
#define SHOP_SAVEORDER SERVER_URL(SERVER_MC,@"Shop_new",@"save_order")


//确认订单信息

#define SHOP_CONFIRMORDER SERVER_URL(SERVER_MC,@"Pay_new",@"check")

//第三方微信支付

#define SHOP_PAYORDERBYWX SERVER_URL(SERVER_MC,@"Pay_new",@"go_pay")




//支付成功后调用接口


#define SHOP_PAYORDERBACK SERVER_URL(SERVER_MC,@"Pay_new",@"app_weixin_back")







//尺寸适配
//尺寸适配
//判断是否是 iPad
#define isPad ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
//判断iPhoneX
#define IS_IPHONE_X ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPHoneXr
#define IS_IPHONE_Xr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1624), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhoneXs
#define IS_IPHONE_Xs ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhoneXs Max
#define IS_IPHONE_Xs_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断是否是留海屏
#define IS_RETAINING_SCREEN IS_IPHONE_X || IS_IPHONE_Xr || IS_IPHONE_Xs || IS_IPHONE_Xs_Max
// 状态栏高度
#define STATUS_BAR_HEIGHT (IS_RETAINING_SCREEN ? 44.f : 20.f)
// 导航栏和状态栏高度
#define HeightForNagivationBarAndStatusBar (IS_RETAINING_SCREEN ? 88.f : 64.f)
// tabBar高度
#define TAB_BAR_HEIGHT (IS_RETAINING_SCREEN ? (49.f+34.f) : 49.f)
// home indicator
#define HOME_INDICATOR_HEIGHT (IS_RETAINING_SCREEN ? 34.f : 0.f)







static NSString * const PLACEHOLDIMAGE = @"placehold-image";

#define GetUser_Login_State [[NSUserDefaults standardUserDefaults] boolForKey:@"USER_IS_LOGIN"]

#define SetUser_Login_State(state) [[NSUserDefaults standardUserDefaults] setBool:state forKey:@"USER_IS_LOGIN"]


#define WeakSelf __weak typeof (self)weakself = self

#define StrongSelf __strong typeof (self)strongself = self




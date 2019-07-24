#import "ShareUI.h"
#import "AppDelegate.h"
#import "CycleHud.h"
#import "TKAlertCenter.h"
#import "HBHttpTool.h"
#import "Singleton.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"
#import "TRClassMethod.h"
#import "TRLib.h"
//#import "DWX_db.h"
#import "TRSuperView.h"
#import "MyRefreshHeader.h"
#import "MyRefreshFooter.h"
#import "TRClassMethod.h"

// 动画时间
#define ANIMATIONDURATION 0.3

// 网络请求单例
#define NETWORK_OPERATOR [SWNetworkManager shareManager]

// app 根视图
#define ROOTVIEW [TRClassMethod getRootView]

//通知中心
#define WTNotificationCenter [NSNotificationCenter defaultCenter]

#define ROOTVC [TRClassMethod getRootVC]

#define RootAddSubView(param) [TRClassMethod addSubView:param]

#define APP_Delegate  ((AppDelegate*)[[UIApplication sharedApplication]delegate])

#define MAINSCREENBOUNDS [[UIScreen mainScreen] bounds]

// 存储单例
#define USERDEFAULTS [NSUserDefaults standardUserDefaults]

#define TR_Singleton [Singleton shareInstance]

#define TR_Message(param)     [TRClassMethod  showMsg:param]

#define NARBAR_Y 20

#define TabbarHeight 50
#define CommonFont  [UIFont systemFontOfSize:14]



#pragma mark  颜色

#define TR_TEXTGrayCOLOR TR_COLOR_RGBACOLOR_A(113, 113, 113, 1.0)
#define TR_MainColor TR_COLOR_RGBACOLOR_A(222,92,59,1)
#define TR_GrayBackground TR_COLOR_RGBACOLOR_A(236, 236, 236, 1.0);
#define TR_LINEGRAYBackground  TR_COLOR_RGBACOLOR_A(186,186,186, 1.0);

#pragma mark  图片

#define TR_Image_Default1 [UIImage imageNamed:@"ezt_default_1"]
#define TR_Image_Default_HospitalLogo [UIImage imageNamed:@"ezt_default_2"]

#pragma mark - 文字

/*
 *全局参数
 */

//百度地图AK
#define MAP_AK  @"r4HouLNaFBG7kOmFWsh8IOoDucQIhbX9"


// 微信相关参数
#define WXAPPSECRET @"19d873e93bfe1b721054ffe712ac5a38"

#define WXAPPID     @"wx41f8b495e4b5faf8"

// 是否已登录
#define DWX_SETLogin_State(param) [USERDEFAULTS setBool:param forKey:@"dwx_isLogin"]
#define DWX_ISLogin [USERDEFAULTS boolForKey:@"dwx_isLogin"]

// 消息提醒状态
#define DWX_SetMessage_State(param) [USERDEFAULTS setBool:param forKey:@"dwx_message"]
#define DWX_Message_State [USERDEFAULTS boolForKey:@"dwx_message"]

//账号
#define DWX_SET_UserName(param) [USERDEFAULTS setObject:param forKey:@"dwx_userName"]
#define DWX_GET_UserName [USERDEFAULTS objectForKey:@"dwx_userName"]

#define DWX_SETNEW_UserName(param) [USERDEFAULTS setObject:param forKey:@"dwx_new_phone"]
#define DWX_GETNEW_UserName [USERDEFAULTS objectForKey:@"dwx_new_phone"]
//密码
#define DWX_SET_PassWord(param) [USERDEFAULTS setObject:param forKey:@"dwx_password"]
#define DWX_GET_PassWord [USERDEFAULTS objectForKey:@"dwx_password"]

// 卖家id
#define SY_SELLERID [NSNumber numberWithInt:[Singleton shareInstance].sellerInfo.seller_id]




// 微信授权code
#define SY_SET_WXCODE(param) [USERDEFAULTS setObject:param forKey:@"WXCode"]
#define SY_GET_WXCODE [USERDEFAULTS objectForKey:@"WXCode"]

// 微信用户openid
#define SY_SET_WXOPENID(param) [USERDEFAULTS setObject:param forKey:@"WXOpenid"]
#define SY_GET_WXOPENID [USERDEFAULTS objectForKey:@"WXOpenid"]

// 微信access_token
#define SY_SET_WXAccess_token(param) [USERDEFAULTS setObject:param forKey:@"WXAccess_token"]
#define SY_GET_WXAccess_token [USERDEFAULTS objectForKey:@"WXAccess_token"]

// 微信授权有效期时间
#define SY_SET_WXExpires_in(param) [USERDEFAULTS setObject:param forKey:@"WXExpires_in"]
#define SY_GET_WXExpires_in [USERDEFAULTS objectForKey:@"WXExpires_in"]

// 微信存储随机串
#define SY_SET_WXNonce(param) [USERDEFAULTS setObject:param forKey:@"WXNonce"]
#define SY_GET_WXNonce [USERDEFAULTS objectForKey:@"WXNonce"]


// 微信存储时间戳
#define SY_SET_WXTime(param) [USERDEFAULTS setObject:param forKey:@"WXTime"]
#define SY_GET_WXTime [USERDEFAULTS objectForKey:@"WXTime"]

// 手机认证信息
#define RENZHENG @"rz"

#define scale_width [UIScreen mainScreen].bounds.size.width/320.0f

#pragma mark -支付宝信息
//合作身份者id，以2088开头的16位纯数字
#define PID @"2088011992275770"


//安全校验码（MD5）密钥，以数字和字母组成的32位字符
#define MD5_KEY @""


#pragma mark -通知




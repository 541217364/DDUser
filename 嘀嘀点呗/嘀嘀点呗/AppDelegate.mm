//
//  AppDelegate.m
//  嘀嘀点呗
//
//  Created by xgy on 2017/11/30.
//  Copyright © 2017年 xgy. All rights reserved.
//

#import "AppDelegate.h"
#import <Bugly/Bugly.h>
#import "BusinessViewController.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <AudioToolbox/AudioToolbox.h>
#import "WXApiManager.h"
#import <AlipaySDK/AlipaySDK.h>
#import "ViewController.h"
#import "BootPageView.h"
#import "OrderManagementViewController.h"
#import "JPUSHService.h"
#import "RootAdvertisementView.h"
#import "AdvertModel.h"
#import <ShareSDKConnector/ShareSDKConnector.h>
#import "MobScreenshotCenter.h"
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
#define MAPKEY  @"iLk0D54jO0Ihy3wuC6dcYRFPO44ewvHw"
BMKMapManager* _mapManager;

static NSString *pushAppKey = @"6e4feb2836bd84d95c2e4e20";
static NSString *channel = @"Publish channel";
static BOOL isProduction = YES;
#define SYSTEM_VERSION_GRATERTHAN_OR_EQUALTO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

@interface AppDelegate ()<BuglyDelegate,WXApiDelegate,JPUSHRegisterDelegate,UNUserNotificationCenterDelegate,UIAlertViewDelegate,UIApplicationDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [[UIApplication sharedApplication] setMinimumBackgroundFetchInterval:UIApplicationBackgroundFetchIntervalMinimum];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.window.backgroundColor = [UIColor whiteColor];
    
   // [self setupBugly];
    // 要使用百度地图，请先启动BaiduMapManager
    _mapManager = [[BMKMapManager alloc]init];
   [self loadMapManager];
    
    self.rootViewController = [[RootTabController alloc]init];
    [self.window setRootViewController:self.rootViewController];
    
    [self.window makeKeyAndVisible];
    
    [self loadversion];
    
    //微信相关
    [WXApi startLogByLevel:WXLogLevelNormal logBlock:^(NSString *log) {
        NSLog(@"log : %@", log);
    }];
    
    //向微信注册
    [WXApi registerApp:@"wx2ae6c139a506a501" enableMTA:YES];

    //向微信注册支持的文件类型
    UInt64 typeFlag = MMAPP_SUPPORT_TEXT | MMAPP_SUPPORT_PICTURE | MMAPP_SUPPORT_LOCATION | MMAPP_SUPPORT_VIDEO |MMAPP_SUPPORT_AUDIO | MMAPP_SUPPORT_WEBPAGE | MMAPP_SUPPORT_DOC | MMAPP_SUPPORT_DOCX | MMAPP_SUPPORT_PPT | MMAPP_SUPPORT_PPTX | MMAPP_SUPPORT_XLS | MMAPP_SUPPORT_XLSX | MMAPP_SUPPORT_PDF;
    
    [WXApi registerAppSupportContentFlag:typeFlag];
    
    
    //注册极光
    [self setPushNotificationWithOptions:launchOptions];
    
    //shareSDK
    
     [[MobScreenshotCenter shareInstance] start];
    
    //判断程序版本
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    
    NSString *app_V = [[NSUserDefaults standardUserDefaults] valueForKey:@"APPVERSION"];
    
    if (![app_Version isEqualToString:app_V]) {
        
        //取消登录 清空数据库操作  解决应用从APPstore下载后 无法保存地址操作
        
        SetUser_Login_State(NO);
        
        [Singleton shareInstance].userInfo = nil;
        
        [[GoodsShonp_DB shareInstance] dropTable];
        
        [[DDStores_DB shareInstance] dropTable];
        
        [[NSUserDefaults standardUserDefaults] setObject:app_Version forKey:@"APPVERSION"];
        
        [self deleteOldImage];
    }
    
    
    //判断程序第一次启动 获取引导页
    if (![[NSUserDefaults standardUserDefaults] valueForKey:@"ISFIRSTLOGINAPP"]) {
        BootPageView *bootPageView = [[BootPageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [bootPageView designViewWithFrame:self.window.frame];
        [self.window addSubview:bootPageView];
    }
    
    NSString *filePath = [USERDEFAULTS valueForKey:adImageName];
    
    if ([self isFileExistWithFilePath:filePath]) {
        
        AdvertModel*model = [[AdvertModel alloc]initWithString:[USERDEFAULTS valueForKey:@"AdvertModel"] error:nil];
        
        if (filePath && model) {
            RootAdvertisementView *advertiseView = [[RootAdvertisementView alloc] initWithFrame:self.window.bounds];
            advertiseView.model = model;
            advertiseView.filePath = filePath;
            [advertiseView show];
            
    }
    
    
   
        
    }else{
        
        [self deleteOldImage];
    }
    
    
    return YES;
}


//百度地图
- (void) loadMapManager {
    BOOL ret = [_mapManager start:MAPKEY generalDelegate:self];
    if (!ret) {
        NSLog(@"manager start failed!");
    }else {
        //启动成功
        _locationService = [[BMKLocationService alloc]init];
        _locationService.delegate=self;
       // _locationService.distanceFilter=10;
        _geocodesearch = [[BMKGeoCodeSearch alloc]init];
        _geocodesearch.delegate = self;
        //[_locationService startUserLocationService];
    }
    
}


#pragma mark 跳转处理
//被废弃的方法. 但是在低版本中会用到.建议写上
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [WXApi handleOpenURL:url delegate:self];
}
//被废弃的方法. 但是在低版本中会用到.建议写上

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [WXApi handleOpenURL:url delegate:self];
}

//新的方法
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options
{
    
    if ([url.absoluteString rangeOfString:@"wx"].length > 0) {
        //微信
        NSRange range = [url.absoluteString rangeOfString:@"code"];
        if (range.location > 0) {
            //微信登录
           
            NSLog(@"微信登录");
        }
        [WXApi handleOpenURL:url delegate:self];
    }
    
    //跳转支付宝钱包进行支付，需要将支付宝钱包的支付结果回传给SDK
    if ([url.host isEqualToString:@"safepay"]) {
        [[AlipaySDK defaultService]
         processOrderWithPaymentResult:url
         standbyCallback:^(NSDictionary *resultDic) {
            
             NSString *statusStr = [NSString stringWithFormat:@"%@",[resultDic objectForKey:@"resultStatus"]];
             
             if (resultDic) {
                 if ([statusStr isEqualToString:@"9000"]) {
                    
                     [[NSNotificationCenter defaultCenter]postNotificationName:@"WXPAYORDERSUCCESS" object:nil];
                     return ;
                 }else if([statusStr isEqualToString:@"6001"]) {
                     
                   TR_Message(@"支付取消");
                     return ;
                 }else {
                   TR_Message(@"支付失败");
                     return ;
                 }
             }else {
                 TR_Message(@"支付失败");
             }
         }];
    }
    
    if (APP_Delegate.rootViewController.selectedIndex==1) {
        
        UINavigationController *nav=APP_Delegate.rootViewController.viewControllers[1];
        
        OrderManagementViewController *orderVC =(OrderManagementViewController *)nav.topViewController;
        [orderVC loadAndRefreshData];
        
    }
    
    return  YES;
}

- (void)onResp:(BaseResp *)resp {
    //接收到微信的回调
    
    
    
    //支付回调
    if ([resp isKindOfClass:[PayResp class]]) {
        if (resp.errCode == WXSuccess) {
            //支付成功 调用支付成功接口
            [[NSNotificationCenter defaultCenter]postNotificationName:@"WXPAYORDERSUCCESS" object:nil];
            
        }else {
            //支付失败
            TR_Message(@"支付失败");
            
        }
    }
    if ([resp isKindOfClass:[SendAuthResp class]]) {

        if (resp.errCode == 0) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"weixinloginsuccess" object:resp ];
        }else{


        }
    }
   
}
   


#pragma mark - mapbaidu

- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    
    _userLocation = userLocation;
    _mylocation   = userLocation.location.coordinate;
        [self onClickReverseGeocode];
        //[_locationService stopUserLocationService];
}

- (void)didFailToLocateUserWithError:(NSError *)error {
    
    NSLog(@"++++++++++++++++%@",error);
    
    if (error &&  [[NSUserDefaults standardUserDefaults] valueForKey:@"ISFIRSTLOGINAPP"]) {
       
        UIAlertView *alter = [[UIAlertView alloc]initWithTitle:@"定位失败" message:@"请打开设置中位置服务" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        alter.tag = 2001;
        [alter show];
        
    }
    
}

- (void)onGetNetworkState:(int)iError
{
    if (0 == iError) {
        NSLog(@"联网成功");
    }
    else{
      
    }
    
}

- (void)onGetPermissionState:(int)iError
{
    if (0 == iError) {
        NSLog(@"授权成功");
        
        [_locationService startUserLocationService];
        
    }
    else {
        NSLog(@"onGetPermissionState %d",iError);
    }
}

//反地理编码
-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    
    if (error == 0) {
        
        if (_locationArray == nil) {
            _locationArray = [NSMutableArray array];
        }
        
        _locationArray=[NSMutableArray arrayWithArray:result.poiList];
        
         [[NSNotificationCenter defaultCenter]postNotificationName:@"UpDateLocationMessage" object:nil];
    }
}

-(void)onClickReverseGeocode{
    CLLocationCoordinate2D pt = (CLLocationCoordinate2D){0, 0};
    if (_userLocation != nil) {
        pt = _userLocation.location.coordinate;
        BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
        reverseGeocodeSearchOption.reverseGeoPoint = pt;
        BOOL flag = [_geocodesearch reverseGeoCode:reverseGeocodeSearchOption];
        if(flag)
        {
            NSLog(@"反geo检索发送成功");
            [_locationService stopUserLocationService];
            UINavigationController *vc= self.rootViewController.viewControllers[0];
            ViewController *viewVC= vc.viewControllers[0];
            [viewVC loaddataManagementwithshow:NO];
            [viewVC loadAndRefreshDatawithshow:NO];
            
            [self getAdFromNetWork];
            
        }
        else
        {
            NSLog(@"反geo检索发送失败");
        }
    }
}

#pragma mark Bugly

- (void)setupBugly {
    // Get the default config
    BuglyConfig * config = [[BuglyConfig alloc] init];
    
    // Open the debug mode to print the sdk log message.
    // Default value is NO, please DISABLE it in your RELEASE version.
    //#if DEBUG
    config.debugMode = YES;
    //#endif
    // Open the customized log record and report, BuglyLogLevelWarn will report Warn, Error log message.
    // Default value is BuglyLogLevelSilent that means DISABLE it.
    // You could change the value according to you need.
    //    config.reportLogLevel = BuglyLogLevelWarn;
    
    // Open the STUCK scene data in MAIN thread record and report.
    // Default value is NO
    config.blockMonitorEnable = YES;
    
    // Set the STUCK THRESHOLD time, when STUCK time > THRESHOLD it will record an event and report data when the app launched next time.
    // Default value is 3.5 second.
    config.blockMonitorTimeout = 1.5;
    
    // Set the app channel to deployment
    config.channel = @"Bugly";
    
    config.delegate = self;
    
    config.consolelogEnable = NO;
    config.viewControllerTrackingEnable = NO;
    
    // NOTE:Required
    // Start the Bugly sdk with APP_ID and your config
    [Bugly startWithAppId:@"a1a991dc7c"
                   config:config];
    
    // Set the customizd tag thats config in your APP registerd on the  bugly.qq.com
    // [Bugly setTag:1799];
    
    [Bugly setUserIdentifier:[NSString stringWithFormat:@"User: %@", [UIDevice currentDevice].name]];
    
    [Bugly setUserValue:[NSProcessInfo processInfo].processName forKey:@"Process"];
    
}


#pragma mark 微信

//- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
//    return  [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
//}
//
//- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
//    return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
//}



#pragma mark 极光

- (void) setPushNotificationWithOptions:(NSDictionary *)launchOptions {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setloadNotifitionObserver) name:kJPFNetworkDidLoginNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setloadNotifition) name:kJPFNetworkDidReceiveMessageNotification object:nil];
    
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
        JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
        if (@available(iOS 10.0, *)) {
            entity.types = UNAuthorizationOptionAlert|UNAuthorizationOptionBadge|UIUserNotificationTypeSound;
        } else {
            // Fallback on earlier versions
        }
        [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
#endif
    } else if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge|
                                                          UIUserNotificationTypeAlert|UIUserNotificationTypeSound)
                                              categories:nil];
    } else {
        //categories 必须为nil
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeAlert|UIUserNotificationTypeSound)
                                              categories:nil];
        
    }
    
    
    //如不需要使用IDFA，advertisingIdentifier 可为nil
    [JPUSHService setupWithOption:launchOptions appKey:pushAppKey
                          channel:channel
                 apsForProduction:isProduction
            advertisingIdentifier:nil];
    
    //2.1.9版本新增获取registration id block接口。
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
        
        if(resCode == 0){
            
            NSLog(@"registrationID获取成功：%@",registrationID);
            
        }
        else{
            NSLog(@"registrationID获取失败，code：%d",resCode);
        }
    }];
    
    if (launchOptions) {
        
        NSDictionary * remoteNotification = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
        //这个判断是在程序没有运行的情况下收到通知，点击通知跳转页面
        if (remoteNotification) {
            NSLog(@"推送消息==== %@",remoteNotification);
            
        }
    }
}


- (void) setloadNotifitionObserver {
    
    
    if ([Singleton shareInstance].userInfo) {
        
        NSString *uuid=[DeviceID stringByAppendingPathComponent:@"-"];
        
        [JPUSHService setTags:[NSSet setWithObject:uuid] callbackSelector:@selector(tagsAliasCallback:tags:) object:nil];
    }
}

- (void) setloadNotifition {
    
    NSLog(@"loadnotifiton");
    
}

-(void)tagsAliasCallback:(int)iResCode
                    tags:(NSSet*)tags

{
    NSLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, tags );
}


- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    NSLog(@"%@", [NSString stringWithFormat:@"Device Token: %@", deviceToken]);
    [JPUSHService registerDeviceToken:deviceToken];
}


- (void)application:(UIApplication *)application
didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}


- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:
(void (^)(UIBackgroundFetchResult))completionHandler {
    
    [JPUSHService handleRemoteNotification:userInfo];

    
    if ([[UIDevice currentDevice].systemVersion floatValue]<10.0 || application.applicationState>0) {
       
    }
    
    completionHandler(UIBackgroundFetchResultNewData);
    
}

#pragma mark- JPUSHRegisterDelegate

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler  API_AVAILABLE(ios(10.0)){
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        
        [JPUSHService handleRemoteNotification:userInfo];
   
        
    }else {
        // 本地通知
    }
    
    completionHandler(UNNotificationPresentationOptionAlert|UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound);
    // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler  API_AVAILABLE(ios(10.0)){
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if (@available(iOS 10.0, *)) {
        if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
            [JPUSHService handleRemoteNotification:userInfo];
    
        }
    } else {
        // Fallback on earlier versions
    }
    
     completionHandler();
   // completionHandler(UNNotificationPresentationOptionAlert|UNNotificationPresentationOptionBadge|UIBackgroundFetchResultNewData);// 系统要求执行这个方法
}



- (void)application:(UIApplication *)application
didReceiveLocalNotification:(UILocalNotification *)notification {
    
    [JPUSHService showLocalNotificationAtFront:notification identifierKey:nil];
    
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    [JPUSHService setBadge:0];
    
//    NSString *filePath = [USERDEFAULTS valueForKey:adImageName];
//    
//    if ([self isFileExistWithFilePath:filePath]) {
//        
//        AdvertModel*model = [[AdvertModel alloc]initWithString:[USERDEFAULTS valueForKey:@"AdvertModel"] error:nil];
//        
//        if (filePath && model) {
//            RootAdvertisementView *advertiseView = [[RootAdvertisementView alloc] initWithFrame:self.window.bounds];
//            advertiseView.model = model;
//            advertiseView.filePath = filePath;
//            [advertiseView show];
//            
//        }
//    }else{
//        
//         [self deleteOldImage];
//        
//    }
    
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


- (void) loadversion {
    
    
    [HBHttpTool post:SHOP_VERSION body:@{} success:^(id responseDic){
       
        
        if (responseDic) {
            
            NSDictionary *dataDict=responseDic;
            
            if ([[dataDict objectForKey:@"errorMsg"] isEqualToString:@"success"]) {
                
                NSDictionary *datadict=[dataDict objectForKey:@"result"];
                
                NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
                
                NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
                
                NSString *force_update=datadict[@"force_update"];
                
                NSString *version=datadict[@"version"];
                
                if ([TRClassMethod versionCompareFirst:app_Version andVersionSecond:version]) {
                    
                    if ([force_update isEqualToString:@"1"]) {
                        
                        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"提示" message:@"有新版本更新" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                        alertView.tag=10000;
                        [alertView show];
                        
                    }else{
                        
                        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"提示" message:@"有新版本更新" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
                        [alertView show];
                    }
                    
                }
                
                
            }
        }
        
    }failure:^(NSError *error){
        
        
        
    }];
    
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    
    if (alertView.tag == 2001) {
        
        [TRClassMethod goToAppSystemNotificationSetting];
        
        return;
    }
   
    
    if (alertView.tag==10000) {
         if (buttonIndex==0)
             [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/cn/app/jie-zou-da-shi/id1314770129?mt=8"]];
        exit(0);
        
    }else{
        
        if (buttonIndex==0) {
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/cn/app/jie-zou-da-shi/id1314770129?mt=8"]];
            exit(0);
            
        }
    
    }
    
}



-(void)getAdFromNetWork{
        // 1.判断沙盒中是否存在广告图片，如果存在，直接显示
//        NSString *filePath = [self getFilePathWithImageName:[USERDEFAULTS valueForKey:adImageName]];
//
//        BOOL isExist = [self isFileExistWithFilePath:filePath];
//        if (isExist) {// 图片存在
//
//            RootAdvertisementView *advertiseView = [[RootAdvertisementView alloc] initWithFrame:self.window.bounds];
//            advertiseView.url = filePath;
//            [advertiseView show];
//
//        }
        // 2.无论沙盒中是否存在广告图片，都需要重新调用广告接口，判断广告是否更新
        [self getAdvertisingImage];
}


/**
 *  判断文件是否存在
 */
- (BOOL)isFileExistWithFilePath:(NSString *)filePath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDirectory = FALSE;
    return [fileManager fileExistsAtPath:filePath isDirectory:&isDirectory];
}

/**
 *  初始化广告页面
 */
- (void)getAdvertisingImage
{
    

    NSString *lat=[NSString stringWithFormat:@"%f",APP_Delegate.mylocation.latitude];
    NSString *lng=[NSString stringWithFormat:@"%f",APP_Delegate.mylocation.longitude];
    
    NSString *ticket = [Singleton shareInstance].userInfo.ticket.length > 0 ? [Singleton shareInstance].userInfo.ticket :@"";
    
    NSDictionary *body = @{@"ticket":ticket,@"Device-Id":DeviceID,@"user_long":lng,@"user_lat":lat};
    
    
    [HBHttpTool post:SHOP_ADVER body:body success:^(id responseDic) {
        
        if ([responseDic[@"errorMsg"] isEqualToString:@"success"]) {
            
            AdvertModel *tempModel = [[AdvertModel alloc]initWithDictionary:responseDic[@"result"] error:nil];
            
            if ([tempModel.type isEqualToString:@"2"]) {
                //视频广告
                
                NSString *movieUrl = tempModel.link;
                // 获取视频
                NSArray *stringArr = [movieUrl componentsSeparatedByString:@"/"];
                NSString *movieName = stringArr.lastObject;
                // 拼接沙盒路径
                NSString *filePath = [self getFilePathWithImageName:movieName];
//                BOOL isExist = [self isFileExistWithFilePath:filePath];
//                if (!isExist){
                
                    [self downloadAdmovieWithUrl:tempModel.link movieName:movieName withPath:filePath with:tempModel];
//                }
                
                
                
            }
            
            if ([tempModel.type isEqualToString:@"1"]) {
                
                //图片广告
                
            NSString *imageUrl = tempModel.link;
        // 获取图片名:43-130P5122Z60-50.jpg
          NSArray *stringArr = [imageUrl componentsSeparatedByString:@"/"];
         NSString *imageName = stringArr.lastObject;
        // 拼接沙盒路径
       // NSString *filePath = [self getFilePathWithImageName:imageName];
//        BOOL isExist = [self isFileExistWithFilePath:filePath];
//        if (!isExist){// 如果该图片不存在，则删除老图片，下载新图片
                
        [self downloadAdImageWithUrl:imageUrl imageName:imageName with:tempModel];
                
//        }
                
            }
            
            
        }
        
        
        
        
    } failure:^(NSError *) {
        
    }];
    
}


/**
 *  新视频
 */


- (void)downloadAdmovieWithUrl:(NSString *)movieUrl movieName:(NSString *)movieName withPath:(NSString *)path with:(AdvertModel *)model
{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:movieUrl]];
        
        if ([data writeToFile:path atomically:YES]) {// 保存成功
            [self deleteOldImage];
            [USERDEFAULTS setValue:path forKey:adImageName];
           
            [USERDEFAULTS setValue:[model toJSONString] forKey:@"AdvertModel"];
           
            
        }else{
            NSLog(@"保存失败");
        }
        
    });
    
}




/**
 *  新图片
 */
- (void)downloadAdImageWithUrl:(NSString *)imageUrl imageName:(NSString *)imageName with:(AdvertModel *)model
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
        UIImage *image = [UIImage imageWithData:data];
        
        NSString *filePath = [self getFilePathWithImageName:imageName]; // 保存文件的名称
        
        if ([UIImagePNGRepresentation(image) writeToFile:filePath atomically:YES]) {// 保存成功
            NSLog(@"保存成功");
            [self deleteOldImage];
            [USERDEFAULTS setValue:imageName forKey:adImageName];
            [USERDEFAULTS setValue:[model toJSONString] forKey:@"AdvertModel"];
            
            // 如果有广告链接，将广告链接也保存下来
        }else{
            NSLog(@"保存失败");
        }
        
    });
}

/**
 *  删除旧图片
 */
- (void)deleteOldImage
{
    NSString *imageName = [USERDEFAULTS valueForKey:adImageName];
    if (imageName) {
        NSString *filePath = [self getFilePathWithImageName:imageName];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager removeItemAtPath:filePath error:nil];
    }
}

/**
 *  根据图片名拼接文件路径
 */
- (NSString *)getFilePathWithImageName:(NSString *)imageName
{
    if (imageName) {
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES);
        NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:imageName];
        
        return filePath;
    }
    
    return nil;
}



@end

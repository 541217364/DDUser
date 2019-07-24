//
//  AppDelegate.h
//  嘀嘀点呗
//
//  Created by xgy on 2017/11/30.
//  Copyright © 2017年 xgy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootTabController.h"
#import <BaiduMapAPI_Location/BMKLocationService.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import <AVFoundation/AVFoundation.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,BMKLocationServiceDelegate,BMKGeneralDelegate,BMKGeoCodeSearchDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) RootTabController *rootViewController;

@property (nonatomic, strong) BMKLocationService *locationService;

@property (nonatomic,strong)BMKGeoCodeSearch* geocodesearch;

@property (nonatomic, assign) BMKUserLocation *userLocation;

@property(nonatomic,strong) NSMutableArray *locationArray;

@property(nonatomic,strong) NSString *addressName;

@property(nonatomic,assign) CLLocationCoordinate2D mylocation;

- (void) loadMapManager;

@end


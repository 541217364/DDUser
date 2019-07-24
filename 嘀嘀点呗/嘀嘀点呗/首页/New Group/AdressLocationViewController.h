//
//  AdressLocationViewController.h
//  送小宝
//
//  Created by xgy on 2017/4/7.
//  Copyright © 2017年 xgy. All rights reserved.
//

#import "ShareUI.h"
#import <BaiduMapAPI_Base/BMKUserLocation.h>

typedef void(^AddCityAdressBlock)(NSString *adressname,CLLocationCoordinate2D userLocation);


@interface AdressLocationViewController : ShareVC

@property (nonatomic, strong) NSString *cityStr;

@property (nonatomic, strong) BMKUserLocation *userLocation;

@property (nonatomic, copy) AddCityAdressBlock cityAdressblock;

@end

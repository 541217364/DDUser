//
//  ChangeAddressViewController.h
//  送小宝
//
//  Created by xgy on 2017/4/8.
//  Copyright © 2017年 xgy. All rights reserved.
//

#import "ShareUI.h"


typedef void(^AddselectAddress)(NSString *addressstr,CLLocationCoordinate2D l_pt);



@interface ChangeAddressViewController : ShareVC

@property (nonatomic, copy) AddselectAddress addressblck;

@property (nonatomic, copy) NSString *lng;

@property (nonatomic, copy) NSString *lat;

@property (nonatomic, copy) NSString *adressName;


- (void)loadloactionAddress;

- (void) loadLocation;

@end

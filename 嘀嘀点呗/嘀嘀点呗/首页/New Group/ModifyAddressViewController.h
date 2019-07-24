//
//  ModifyAddressViewController.h
//  送小宝
//
//  Created by xgy on 2017/3/13.
//  Copyright © 2017年 xgy. All rights reserved.
//

#import "ShareUI.h"
#import "UserAddressModel.h"

@interface ModifyAddressViewController : ShareVC

@property (nonatomic, strong) UserAddressModel *model;

@property (nonatomic, copy) NSString *lng;

@property (nonatomic, copy) NSString *lat;

@property (nonatomic, copy) NSString *mtitlename;

@property(nonatomic,assign)  BOOL   resourceType; //判断添加地址的来源 YES是从结算界面来的

@property (nonatomic, assign) BOOL isNewAdress;

@end

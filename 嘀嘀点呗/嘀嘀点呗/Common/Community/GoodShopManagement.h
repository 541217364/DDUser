//
//  GoodShopManagement.h
//  嘀嘀点呗
//
//  Created by xgy on 2018/5/29.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "StoreDataModel.h"
#import "DDStores_DB.h"
#import "GoodsShopModel.h"
#import "GoodsShonp_DB.h"

@interface GoodShopManagement : NSObject

+ (instancetype)shareInstance;

- ( void) addStore:(StoreDataModel *)model  andGoodshopmodel:(GoodsShopModel *)gmodel;

- ( void) deleteStore:(StoreDataModel *)model  andGoodshopmodel:(GoodsShopModel *)gmodel;

- (NSMutableArray *)getStoresdataInfo;

- (GoodsShopModel *)getstoreId:(NSString *)storeid  goodid:(NSString *)gooid  specId:(NSString *)specid  attributeId:(NSString *)attributeid  attrubutetip:(NSString *)tip;

@end

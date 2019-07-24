//
//  DBManagement.h
//  嘀嘀点呗
//
//  Created by xgy on 2018/5/20.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDShop_DB.h"
#import "DDStores_DB.h"
#import "DDSpec_DB.h"
#import "GoodDataModel.h"
#import "StoreDataModel.h"
#import "AttributeModel.h"
#import "Attribute_DB.h"

@interface DBManagement : NSObject

+ (instancetype)shareInstance;

- (void) deleteStoreModel:(StoreDataModel *)model;

- (void)inserInforstoreModel:(StoreDataModel *)model;

- (void) inerinforGoodmodel:(GoodDataModel *)model;

- (void) interinforSpecModel:(DBGoodSpecModel *)model;

- (void)deleteGoodModel:(GoodDataModel *)model;

- (void)deleteSpecModel:(DBGoodSpecModel *)model;

- (NSMutableArray *)getStoresData;

- (void)addStoreData:(NSDictionary *)sdict  andGoodData:(NSDictionary *)gdict attburiteValue:(NSString *)value;

- (void) deleteStoreData:(NSDictionary *)sdict   andGoodData:(NSDictionary *)gdict attburiteValue:(NSString *)value;

- (void)addStoreData:(NSDictionary *)sdict  andGoodData:(NSDictionary *)gdict  specData:(NSDictionary *)specdict withAttValuesDict:(NSDictionary *)dictvalue;

- (void) deleteStoreData:(NSDictionary *)sdict   andGoodData:(NSDictionary *)gdict specData:(NSDictionary *)specdict withAttValuesDict:(NSDictionary *)dictvalue;

- (void) deleteStoreModel:(StoreDataModel *)smodel  andGoodModel:(GoodDataModel *)gmodel  specModel:(DBGoodSpecModel*) specmodel;

- (void) deleteStoreModel:(StoreDataModel *)smodel  andGoodModel:(GoodDataModel *)gmodel;


@end

//
//  GoodsListManager.h
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/5/19.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StoreSeachModel.h"
#import "StoreInfo.h"
#import "GoodDataModel.h"
#import "GoodsShopModel.h"
#import "StoreDataModel.h"

@interface GoodsListManager : NSObject

@property (nonatomic, strong)NSMutableArray *goodsListArray;

+ (instancetype)shareInstance;


//删除订单
-(void)deleteShopOrder:(NSString *)shopID;

-(NSArray *)getGoodsCount:(NSString *)shopID;

-(void)setGoodsSelectCount:(NSString *)shopID;

-(GoodsShopModel *)getSelectGoodsFromDB:(NSString *)shopID withGoodMark:(NSString *)mark;

-(void)setSelctModelCount:(ProductItem *)model withCount:(NSString *)selectCount;

-(GoodItem *)transformModelFrom:(ProductItem *)model withShopID:(NSString *)shopID;


-(GoodDataModel *)transformModelFrom2:(ProductItem *)model withShopID:(NSString *)shopID;

-(GoodsShopModel *)transformModelFrom3:(ProductItem *)model withShopID:(NSString *)shopID;

-(StoreDataModel *)transformModelFrom4:(StoreModel *)model;

-(ProductItem *)transformModelFrom5:(GoodsShopModel *)model;

@end

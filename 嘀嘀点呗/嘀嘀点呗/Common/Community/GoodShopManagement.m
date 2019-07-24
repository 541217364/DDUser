//
//  GoodShopManagement.m
//  嘀嘀点呗
//
//  Created by xgy on 2018/5/29.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import "GoodShopManagement.h"

@implementation GoodShopManagement

+ (instancetype)shareInstance
{
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
        
        [GoodsShonp_DB shareInstance].name=@"goodshoptable";
        [DDStores_DB shareInstance].name=@"storetable";

         [[DDStores_DB shareInstance] createDBWithPath:[DDStores_DB shareInstance].m_dbPath withTablename:[DDStores_DB shareInstance].name];
        [[GoodsShonp_DB shareInstance] createDBWithPath:[GoodsShonp_DB shareInstance].m_dbPath withTablename:[GoodsShonp_DB shareInstance].name];
        
    });
    return instance;
}


- ( void) addStore:(StoreDataModel *)model  andGoodshopmodel:(GoodsShopModel *)gmodel {
    
     NSMutableArray *goodarray=[[GoodsShonp_DB shareInstance] getFootprintGoodsforstoreInfoArrayforkey:model.store_id];
   
    DBStoreModel *smodel=model;
    
    if (goodarray.count==0) {
        
        [[DDStores_DB shareInstance] addFootprintInfoWtihDict:smodel.toDictionary];
    }
    
    gmodel.marking=[NSString stringWithFormat:@"%@,%@,%@,%@,%@",gmodel.storeid,gmodel.goodId,gmodel.specId,gmodel.attributeId,gmodel.atttip];
    
    [[GoodsShonp_DB shareInstance] addFootprintInfoWtihDict:gmodel.toDictionary];
}

- ( void) deleteStore:(StoreDataModel *)model  andGoodshopmodel:(GoodsShopModel *)gmodel {
  
    DBStoreModel *smodel=model;

    NSInteger num=[gmodel.goodnum integerValue];
    
   gmodel.marking=[NSString stringWithFormat:@"%@,%@,%@,%@,%@",gmodel.storeid,gmodel.goodId,gmodel.specId,gmodel.attributeId,gmodel.atttip];

    if (num==0) {
        gmodel.goodnum=@"1";
     
        [[GoodsShonp_DB shareInstance] deleteFootprintInfo:gmodel];
      
        NSMutableArray *goodarray=[[GoodsShonp_DB shareInstance] getFootprintGoodsforstoreInfoArrayforkey:model.store_id];
        
        if (goodarray.count==0) {
            
            DBStoreModel *dbmodel=[[DBStoreModel alloc]initWithDictionary:smodel.toDictionary  error:nil];
            
            [[DDStores_DB shareInstance] deleteFootprintInfo:dbmodel];
        }        
    }else
        [[GoodsShonp_DB shareInstance] addFootprintInfoWtihDict:gmodel.toDictionary];
}


- (NSMutableArray *)getStoresdataInfo {
    
    NSMutableArray *marray=[NSMutableArray array];
    
    NSMutableArray *array=[[DDStores_DB shareInstance] getFootprintInfoArray];
    
    for (DBStoreModel *model in array) {
        
        StoreDataModel *mmodel=[[StoreDataModel alloc]initWithDictionary:model.toDictionary error:nil];
        
        mmodel.goods=[[GoodsShonp_DB shareInstance] getFootprintGoodsforstoreInfoArrayforkey:mmodel.store_id];
       
        [marray addObject:mmodel];
    }
    return marray;
}

- (GoodsShopModel *)getstoreId:(NSString *)storeid  goodid:(NSString *)gooid  specId:(NSString *)specid  attributeId:(NSString *)attributeid  attrubutetip:(NSString *)tip {
    
    NSString *marking=[NSString stringWithFormat:@"%@,%@,%@,%@,%@",storeid,gooid,specid,attributeid,tip];
    
    NSMutableArray *arr=[[GoodsShonp_DB shareInstance] getFootprintGoodsforMarkingInfoArrayforkey:marking];
    
    GoodsShopModel *model= [arr firstObject];
    
    return model;
}


@end

//
//  GoodsListManager.m
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/5/19.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import "GoodsListManager.h"

@implementation GoodsListManager



// 获取单例
+ (instancetype)shareInstance
{
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
        
    });
    return instance;
}

- (id)init
{
    self = [super init];
    if (self) {
      
    }
    return self;
}

-(NSMutableArray *)goodsListArray{
    if (_goodsListArray == nil) {
        _goodsListArray = [NSMutableArray array];
    }
    return _goodsListArray;
}







-(void)deleteShopOrder:(NSString *)shopID{
    
    NSArray *saveArray =  [[GoodShopManagement shareInstance]getStoresdataInfo];
    
    for (StoreDataModel *model in saveArray) {
        
        if ([model.store_id isEqualToString:shopID]) {
            
            if (model.goods.count > 0) {
                
                for (GoodsShopModel *goodModel in model.goods) {
                    
                    [[GoodsShonp_DB shareInstance] deleteFootprintInfo:goodModel];
                    
                }
            }
            
            DBStoreModel *dbstoremodel=[[DBStoreModel alloc]initWithDictionary:model.toDictionary error:nil];
            [[DDStores_DB shareInstance] deleteFootprintInfo:dbstoremodel];
            return;
        }
    }
}


-(GoodsShopModel *)getSelectGoodsFromDB:(NSString *)shopID withGoodMark:(NSString *)mark {
    
    NSArray *saveArray =  [[GoodShopManagement shareInstance]getStoresdataInfo];
    
    for (StoreDataModel *storeModel in saveArray) {
        
        if ([storeModel.store_id isEqualToString:shopID]) {
            if (storeModel.goods.count > 0) {
                
                for (GoodsShopModel *goodsmodel in storeModel.goods) {
                    
                    if ([goodsmodel.marking isEqualToString:mark]) {
                        
                        return goodsmodel;
                       
                    }
                }
                
            }
        }
    }
    
    return nil;
}




-(NSArray *)getGoodsCount:(NSString *)shopID;{
    
    NSArray *saveArray =  [[GoodShopManagement shareInstance]getStoresdataInfo];
    
    for (StoreDataModel *storeModel in saveArray) {
        
        if ([storeModel.store_id isEqualToString:shopID]) {
            
            return storeModel.goods;
           
        }
    }
    
    return nil;
}



-(void)setGoodsSelectCount:(NSString *)shopID{
    
    NSArray *saveArray =  [[GoodShopManagement shareInstance]getStoresdataInfo];
    
    
    for (NSArray *tempArray in [GoodsListManager shareInstance].goodsListArray) {
        
    for (ProductItem *productitem in tempArray) {
            
        NSInteger count = 0;
    
    for (StoreDataModel *storeModel in saveArray) {
        
        if ([storeModel.store_id isEqualToString:shopID]) {
            
                    if (storeModel.goods.count > 0) {
                        
                        for (GoodsShopModel *tempModel in storeModel.goods) {
                            
                            if ([productitem.product_id isEqualToString:tempModel.goodId]) {
                               
                                count = count + [tempModel.goodnum integerValue];
                                
                                if ([productitem.sort_discount doubleValue] > 0) {
                                    
                                    tempModel.gooddiscountprice = productitem.sort_discount;
                                }
                                tempModel.is_skill   = productitem.is_seckill_price;
                                tempModel.skillprice = productitem.product_price;
                                tempModel.goodpick   = productitem.packing_charge;
                                tempModel.goodprice  = productitem.product_price;
                                tempModel.goodimg    = productitem.product_image;
                                tempModel.goodname   = productitem.product_name;
                                tempModel.o_price    = productitem.o_price;
                                [[GoodShopManagement shareInstance] addStore:storeModel andGoodshopmodel:tempModel];
                                
                            }
                            
                        }
                        
                    }
                  
            
                }
            }

        productitem.selectCount = [NSString stringWithFormat:@"%ld",count];
        
        }
    }
    
}



-(void)setSelctModelCount:(ProductItem *)model withCount:(NSString *)selectCount{
    
    for (NSArray *temp in _goodsListArray) {
        for (ProductItem *tempModel in temp) {
            
            if (tempModel == model) {
                
                model.selectCount = selectCount;
                
            }
        }
    }
}


-(GoodItem *)transformModelFrom:(ProductItem *)model withShopID:(NSString *)shopID{
    
    GoodItem *aimModel = [[GoodItem alloc]init];
    aimModel.goods_id = model.product_id;
    aimModel.g_image  = model.product_image;
    aimModel.price    = model.product_price;
    aimModel.store_id = shopID;
    aimModel.unit = model.unit;
    aimModel.name = model.product_name;
    aimModel.packing_charge = model.packing_charge;
    aimModel.sort_discount = model.sort_discount;

    return aimModel;
}





-(GoodDataModel *)transformModelFrom2:(ProductItem *)model withShopID:(NSString *)shopID{
    GoodDataModel *aimModel = [[GoodDataModel alloc]init];
    aimModel.store_id = shopID;
    aimModel.goodname = model.product_name;
    aimModel.goodId = model.product_id;
    aimModel.goodprice = model.product_price;
    aimModel.goodnum = model.selectCount;
    aimModel.goodnum = model.product_name;
    aimModel.goodimg = model.product_image;
    aimModel.pickprice = model.packing_charge;
    aimModel.attributename = @"";
    
    return aimModel;
}


-(GoodsShopModel *)transformModelFrom3:(ProductItem *)model withShopID:(NSString *)shopID{
    
    GoodsShopModel *aimModel = [[GoodsShopModel alloc]init];
    aimModel.storeid = shopID;
    aimModel.goodId = model.product_id;
    aimModel.goodnum = model.selectCount;
    aimModel.goodpick = model.packing_charge;
    aimModel.goodprice = model.product_price;
    aimModel.goodimg = model.product_image;
    aimModel.goodname = model.product_name;
    aimModel.gooddiscountprice = model.sort_discount;
    aimModel.is_skill = model.is_seckill_price;
    aimModel.skillprice = model.product_price;
    aimModel.o_price = model.o_price;
    aimModel.atttip = @"0";
    aimModel.marking = [NSString stringWithFormat:@"%@,%@,%@,%@,%@",aimModel.storeid,aimModel.goodId,aimModel.specId,aimModel.attributeId,aimModel.atttip];
    if ([model.sort_discount doubleValue] > 0) {
        
        aimModel.gooddiscountprice = model.sort_discount;
    }
    
    
    return aimModel;
}


-(StoreDataModel *)transformModelFrom4:(StoreModel *)model{
    
    StoreDataModel *aimModel = [[StoreDataModel alloc]init];
    aimModel.store_id = model.store_id;
    aimModel.storename = model.name;
    aimModel.storeimg = model.image;
    aimModel.sendprice = model.delivery_price;
    NSString *str=@"";
    for (int i =0; i<model.tag.count; i++) {
        NSString *s=model.tag[i];
        
        if (i==0) {
            str=s;
        }else
            str=[NSString stringWithFormat:@"%@,%@",str,s];
      
    }
    
    aimModel.activity=str;
    return aimModel;
    
}

-(ProductItem *)transformModelFrom5:(GoodsShopModel *)model{
    
    for (NSArray *tempArray in [GoodsListManager shareInstance].goodsListArray) {
        
        for (ProductItem *productitem in tempArray) {
            
            if ([productitem.product_id isEqualToString:model.goodId] && [productitem.product_name isEqualToString:model.goodname]) {
                
                return productitem;
            }
        }
        
    }
    return nil;
}

@end

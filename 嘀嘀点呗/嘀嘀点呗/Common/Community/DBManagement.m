//
//  DBManagement.m
//  嘀嘀点呗
//
//  Created by xgy on 2018/5/20.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import "DBManagement.h"

@implementation DBManagement

+ (instancetype)shareInstance
{
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
        
        [DDStores_DB shareInstance].name=@"storetable";
        
        [DDShop_DB shareInstance].name=@"goodtable";
        
        [DDSpec_DB shareInstance].name=@"spectable";
        
        [DDSpec_DB shareInstance].name=@"Attributetable";

        
          [[DDStores_DB shareInstance] createDBWithPath:[DDStores_DB shareInstance].m_dbPath withTablename:[DDStores_DB shareInstance].name];
        
          [[DDShop_DB shareInstance] createDBWithPath:[DDShop_DB shareInstance].m_dbPath withTablename:[DDShop_DB shareInstance].name];
        
           [[DDSpec_DB shareInstance] createDBWithPath:[DDSpec_DB shareInstance].m_dbPath withTablename:[DDSpec_DB shareInstance].name];
        
           [[Attribute_DB shareInstance] createDBWithPath:[DDSpec_DB shareInstance].m_dbPath withTablename:[Attribute_DB shareInstance].name];

    });
    return instance;
}


- (NSMutableArray *)getStoresData {
    
    NSMutableArray *arr= [[DDStores_DB shareInstance] getFootprintInfoArray];
    
    NSArray *data=[DBStoreModel  arrayOfDictionariesFromModels:arr];
    
    NSMutableArray *array=[StoreDataModel arrayOfModelsFromDictionaries:data];
    
    [self getgoods:array];
    
  return  array;
    
}

- (void)getgoods:(NSMutableArray *)stores {
    
    
    for (StoreDataModel *model in stores) {
        
     //   NSMutableArray *array=[[DDShop_DB shareInstance] getFootprintInfoArrayforkey:model.store_id];
        
        NSArray *dataArr=[ShopModel arrayOfDictionariesFromModels:[[DDShop_DB shareInstance] getFootprintInfoArrayforkey:model.store_id]];
        NSMutableArray *array=[GoodDataModel arrayOfModelsFromDictionaries:dataArr];
      
        [self getGoodSpecs:array];
     
        model.goods=array;
    }
}

- (void)getGoodSpecs:(NSMutableArray *)goods {
    
    for (GoodDataModel *model in goods) {
        
        NSMutableArray *array=[[DDSpec_DB shareInstance] getFootprintGoodsforSpecsInfoArrayforkey:model.goodId];
        
        model.specs=array;
    }
}

- (void)inserInforstoreModel:(StoreDataModel *)model {
    
    DBStoreModel *model2=[[DBStoreModel alloc]initWithDictionary:[model toDictionary] error:nil];
    
    NSMutableDictionary *dict=[NSMutableDictionary dictionaryWithDictionary:[model2 toDictionary]];
    
    [[DDStores_DB shareInstance] addFootprintInfoWtihDict:dict];
    
}


- (void) inerinforGoodmodel:(GoodDataModel *)model {
    
    ShopModel *model2=[[ShopModel alloc]initWithDictionary:[model toDictionary] error:nil];
    
    NSMutableDictionary *dict=[NSMutableDictionary dictionaryWithDictionary:[model2 toDictionary]];

    [[DDShop_DB shareInstance] addFootprintInfoWtihDict:dict];
    
}

- (void) interinforSpecModel:(DBGoodSpecModel *)model {
    
    NSMutableDictionary *dict=[NSMutableDictionary dictionaryWithDictionary:[model toDictionary]];
    
    [[DDSpec_DB shareInstance] addFootprintInfoWtihDict:dict];;
}




- (void) deleteStoreModel:(StoreDataModel *)model {
    
    DBStoreModel *model2=[[DBStoreModel alloc]initWithDictionary:[model toDictionary] error:nil];
    
    [[DDStores_DB shareInstance] deleteFootprintInfo:model2];
}



- (void)deleteGoodModel:(GoodDataModel *)model {
    
    ShopModel *model2=[[ShopModel alloc]initWithDictionary:[model toDictionary] error:nil];
    
    [[DDShop_DB shareInstance] deleteFootprintInfo:model2];
}


- (void)deleteSpecModel:(DBGoodSpecModel *)model {
    
    [[DDSpec_DB shareInstance] deleteFootprintInfo:model];;
}


- (void) interAttributeModel:(AttributeModel *) model {
    
    NSMutableDictionary *dict=[NSMutableDictionary dictionaryWithDictionary:[model toDictionary]];
    [[Attribute_DB shareInstance] addFootprintInfoWtihDict:dict];
    
}

- (void) deleteAttributeModel:(AttributeModel *) model {
    
    // NSMutableDictionary *dict=[NSMutableDictionary dictionaryWithDictionary:[model toDictionary]];
    [[Attribute_DB shareInstance] deleteFootprintInfo:model];

}


- (void)addStoreData:(NSDictionary *)sdict  andGoodData:(NSDictionary *)gdict {
    
        StoreDataModel *model=[[StoreDataModel alloc]init];
        model.store_id=sdict[@"store_id"];
        model.storename=sdict[@"name"];
        model.sendprice=sdict[@"delivery_price"];
        model.activity=sdict[@"store_mj"];
        model.storeimg=sdict[@"image"];
    
        GoodDataModel *mModel=[[GoodDataModel alloc]init];
        mModel.goodId=gdict[@"goods_id"];
    
        mModel.goodname=gdict[@"name"];
    
        mModel.goodprice=gdict[@"price"];
    
        mModel.goodnum=gdict[@"goodnum"];
    
        mModel.goodimg=gdict[@"g_image"];
    
        mModel.pickprice=gdict[@"packing_charge"];

        mModel.store_id=model.store_id;
    
//        if (attDict) {
//          
//            mModel.attributename=attDict[@""];
//
//        }
    
//        NSMutableArray *array=[[DDShop_DB shareInstance] getFootprintInfoArrayforkey:mModel.store_id];
    
//    if (array&&array.count==0) {
//
//        [self inserInforstoreModel:model];
//    }else
    
    
//        if (attDict) {
//
//            AttributeModel *attmodel=[[AttributeModel alloc]init];
//
//            attmodel.attributeId=attDict[@"id_"];
//
//            attmodel.attributename=attDict[@"attbutename"];
//
//            attmodel.attributenum=mModel.goodnum;
//
//            attmodel.goodId=attDict[@"goods_id"];
//
//            attmodel.atttip=attDict[@"tipindex"];
//
//
//        }else
    
            [self inerinforGoodmodel:mModel];

    
    [self inserInforstoreModel:model];
    
}


- (void) deleteStoreData:(NSDictionary *)sdict   andGoodData:(NSDictionary *)gdict {
    
    StoreDataModel *model=[[StoreDataModel alloc]init];
    model.store_id=sdict[@"store_id"];
    model.storename=sdict[@"name"];
    model.sendprice=sdict[@"delivery_price"];
    model.activity=sdict[@"store_mj"];
    model.storeimg=sdict[@"image"];

    GoodDataModel *mModel=[[GoodDataModel alloc]init];
    
    mModel.goodId=gdict[@"goods_id"];
    
    mModel.goodname=gdict[@"name"];
    
    mModel.goodprice=gdict[@"price"];
    
    mModel.goodnum=gdict[@"goodnum"];
  
    mModel.goodimg=gdict[@"g_image"];
    
    mModel.pickprice=gdict[@"packing_charge"];
    
    mModel.store_id=model.store_id;
    
    if ([mModel.goodnum integerValue]==0) {
    
        mModel.goodnum=@"1";
        
        [self deleteGoodModel:mModel];
        
    }else
        [self inerinforGoodmodel:mModel];

    
    NSMutableArray *array=[[DDShop_DB shareInstance] getFootprintInfoArrayforkey:mModel.store_id];

    if (array&&array.count==0) {
        
        [self deleteStoreModel:model];
        
    }
}


- (void) deleteStoreData:(NSDictionary *)sdict   andGoodData:(NSDictionary *)gdict specData:(NSDictionary *)specdict withAttValuesDict:(NSDictionary *)dictvalue{
    
    if (!specdict&&!dictvalue) {
        
        [self deleteStoreData:sdict andGoodData:gdict];
        
    }else{
    
    StoreDataModel *model=[[StoreDataModel alloc]init];
        
    model.store_id=sdict[@"store_id"];
    model.storename=sdict[@"name"];
    model.sendprice=sdict[@"delivery_price"];
    model.activity=sdict[@"store_mj"];

    model.storeimg=sdict[@"image"];
    
    GoodDataModel *mModel=[[GoodDataModel alloc]init];
    
    mModel.goodId=gdict[@"goods_id"];
    
    mModel.goodname=gdict[@"name"];
    
    mModel.goodprice=gdict[@"price"];
    
    mModel.goodnum=gdict[@"goodnum"];
    
    mModel.goodimg=gdict[@"g_image"];
    
    mModel.pickprice=gdict[@"packing_charge"];
    
    mModel.store_id=model.store_id;

    
    DBGoodSpecModel *specmodel=[[DBGoodSpecModel alloc]init];
        
        if (specdict) {
            
            specmodel.specId=specdict[@"id_"];
           
            specmodel.specnum=specdict[@"specnum"];
            
            specmodel.specprice=specdict[@"price"];
            
            specmodel.specname=specdict[@"name"];
            
            specmodel.pickprice=specdict[@"packing_charge"];
            
            specmodel.goodId=gdict[@"goods_id"];

            
        }
        
        AttributeModel *attmodel=[[AttributeModel alloc]init];
        
        if (dictvalue) {
            
            attmodel.attributeId=dictvalue[@"id_"];
            
            attmodel.attributename=dictvalue[@"attbutename"];
            
            attmodel.attributenum=dictvalue[@"num"];
            
            attmodel.goodId=dictvalue[@"goods_id"];
            
            attmodel.atttip=dictvalue[@"tipindex"];
           
            specmodel.attribute=dictvalue[@"attbutename"];
         
            mModel.attributename=dictvalue[@"attbutename"];
            
            if (specdict) {
                
                attmodel.specId=specdict[@"id_"];
                
            }
            
            [self deleteAttributeModel:attmodel];
        }
        
    
    if ([specmodel.specnum integerValue]==0) {
        
        specmodel.specnum=@"1";
      
        [self deleteSpecModel:specmodel];
        
    }else{
        
        [self interinforSpecModel:specmodel];
    }
   
    NSMutableArray *specArray=[[DDSpec_DB shareInstance] getFootprintGoodsforSpecsInfoArrayforkey:specmodel.goodId];

    if (specArray.count==0) {
        
       // mModel.goodnum=@"1";
      
        [self deleteGoodModel:mModel];
     
        NSMutableArray *goodarray=[[DDShop_DB shareInstance] getFootprintInfoArrayforkey:mModel.store_id];
        
        if (goodarray&&goodarray.count==0) {

            [self deleteStoreModel:model];

        }
        
    }
    
    }
}

- (void)addStoreData:(NSDictionary *)sdict  andGoodData:(NSDictionary *)gdict  specData:(NSDictionary *)specdict withAttValuesDict:(NSDictionary *)dictvalue{
    
    if (!specdict&&!dictvalue) {
        
        [self addStoreData:sdict andGoodData:gdict ];
        
    }else{
    
    StoreDataModel *model=[[StoreDataModel alloc]init];
    model.store_id=sdict[@"store_id"];
    model.storename=sdict[@"name"];
    model.sendprice=sdict[@"delivery_price"];
    model.activity=sdict[@"store_mj"];
    model.storeimg=sdict[@"image"];
    
    GoodDataModel *mModel=[[GoodDataModel alloc]init];
    
    mModel.goodId=gdict[@"goods_id"];
    
    mModel.goodname=gdict[@"name"];
    
    mModel.goodprice=gdict[@"price"];
    
    mModel.goodnum=gdict[@"goodnum"];
    
    mModel.goodimg=gdict[@"g_image"];
    
    mModel.pickprice=gdict[@"packing_charge"];
    
    mModel.store_id=model.store_id;
   
    
    DBGoodSpecModel *specmodel=[[DBGoodSpecModel alloc]init];
    
    specmodel.specId=specdict[@"id_"];
    
    specmodel.specnum=specdict[@"specnum"];
    
    specmodel.specprice=specdict[@"price"];
    
    specmodel.specname=specdict[@"name"];
    
    specmodel.pickprice=specdict[@"packing_charge"];
    
    specmodel.goodId=gdict[@"goods_id"];
        
    AttributeModel *attmodel=[[AttributeModel alloc]init];
        
        if (dictvalue) {
            
            attmodel.attributeId=dictvalue[@"id_"];
            
            attmodel.attributename=dictvalue[@"attbutename"];
            
            attmodel.attributenum=dictvalue[@"num"];
            
            attmodel.goodId=dictvalue[@"goods_id"];
            
            attmodel.atttip=dictvalue[@"tipindex"];
            
            specmodel.attribute=specdict[@"name"];
            
            mModel.attributename=specdict[@"name"];
            
            
            if (specdict) {
                
                attmodel.specId=specdict[@"id_"];
                
            }
            [self interAttributeModel:attmodel];

        }
  
  
    NSMutableArray *specArray=[[DDSpec_DB shareInstance] getFootprintGoodsforSpecsInfoArrayforkey:specmodel.goodId];
    
    if (specArray&&specArray.count==0) {
        
        NSMutableArray *goodarray=[[DDShop_DB shareInstance] getFootprintInfoArrayforkey:mModel.store_id];
      
        [self inerinforGoodmodel:mModel];

       // if (goodarray&&goodarray.count==0) {
            [self inserInforstoreModel:model];
       // }
    }
        [self interinforSpecModel:specmodel];
        
    }
}


- (void) deleteStoreModel:(StoreDataModel *)smodel  andGoodModel:(GoodDataModel *)gmodel  specModel:(DBGoodSpecModel*) specmodel {
    
    if ([specmodel.specnum integerValue]==0) {
        
        specmodel.specnum=@"1";
        
        [self deleteSpecModel:specmodel];
        
    }else{
        
        [self interinforSpecModel:specmodel];
    }
    
    NSMutableArray *specArray=[[DDSpec_DB shareInstance] getFootprintGoodsforSpecsInfoArrayforkey:specmodel.goodId];
    
    if (specArray.count==0) {
        
        [self deleteGoodModel:gmodel];
        
        NSMutableArray *goodarray=[[DDShop_DB shareInstance] getFootprintInfoArrayforkey:gmodel.store_id];
        
        if (goodarray&&goodarray.count==0) {
            
            [self deleteStoreModel:smodel];
            
        }
    }
}

- (void)deleteStoreModel:(StoreDataModel *)smodel andGoodModel:(GoodDataModel *)gmodel {
    
    if ([gmodel.goodnum integerValue]==0) {
        
        gmodel.goodnum=@"1";
        
        [self deleteGoodModel:gmodel];
        
    }else
        [self inerinforGoodmodel:gmodel];
    
    
    NSMutableArray *array=[[DDShop_DB shareInstance] getFootprintInfoArrayforkey:gmodel.store_id];
    
    if (array&&array.count==0) {
        
        [self deleteStoreModel:smodel];
        
    }
    
}

@end

//
//  GoodsChooseModel.h
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/5/14.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodsChooseModel : NSObject

@property(nonatomic,strong)NSString *shopID;

@property(nonatomic,strong)NSString *shopName;

@property(nonatomic,strong)NSString *shopImage;

@property(nonatomic,strong)NSString *image;

@property(nonatomic,strong)NSString *productName;

@property(nonatomic,strong)NSString *productId;

@property(nonatomic,strong)NSString *goodsPrice;

@property(nonatomic,strong)NSString *spcID;

@property(nonatomic,strong)NSString *spec_id;

@property(nonatomic,strong)NSString *spc_name;

@property(nonatomic,strong)NSString *spc_selectName;

@property(nonatomic,strong)NSString *pro_id;

@property(nonatomic,strong)NSString *pro_name;

@property(nonatomic,strong)NSString *list_id;

@property(nonatomic,strong)NSString *goodsCount;

@property(nonatomic,strong)NSString *nickName;


/*
 
 选择的商品  model
 
 
 productName  商品名字
 productId    商品ID
 spcID        规格ID     规格ID
 spec_id      详细的规格ID  大  小  ID
 
 spc_name   规格 名字   规格名字
 
 spc_selectName  选择规格名
 
 pro_id     属性选择的下标
 
 pro_name   属性名   冷 热  J
 
 list_id   属性ID
 
 
 就这样吧  有点蒙比了
 
 
 折扣什么的没有写  后面再弄吧
 
 *
 *
 */




@end

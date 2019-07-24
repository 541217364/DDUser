//
//  ProductOrderGoodModel.h
//  嘀嘀点呗
//
//  Created by xgy on 2018/5/30.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import "JSONModel.h"

@interface ProductOrderGoodModel : JSONModel

@property (nonatomic, copy)NSString<Optional> * des;

@property (nonatomic, copy)NSString<Optional> * discount_price;

@property (nonatomic, copy)NSString<Optional> * goods_name;

@property (nonatomic, copy)NSString<Optional> * has_format;

@property (nonatomic, copy)NSString<Optional> * is_seckill_price;

@property (nonatomic, copy)NSString<Optional> * old_price;

@property (nonatomic, copy)NSString<Optional> * packing_charge;

@property (nonatomic, copy)NSString<Optional> * product_image;

@property (nonatomic, copy)NSString<Optional> * product_reply;

@property (nonatomic, copy)NSString<Optional> * product_sale;

@property (nonatomic, copy)NSString<Optional> * stock;

@property (nonatomic, copy)NSString<Optional> * unit;

@property (nonatomic, copy)NSString<Optional> *max_num;






@end

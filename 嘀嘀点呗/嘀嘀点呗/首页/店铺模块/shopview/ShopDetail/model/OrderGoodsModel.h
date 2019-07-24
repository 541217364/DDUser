//
//  OrderGoodsModel.h
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/5/16.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import "JSONModel.h"

@interface OrderGoodsModel : JSONModel

@property (nonatomic, copy)NSString<Optional> * cost_price;

@property (nonatomic, copy)NSString<Optional> * discount_price;

@property (nonatomic, copy)NSString<Optional> * discount_price_all;

@property (nonatomic, copy)NSString<Optional> * discount_rate;

@property (nonatomic, copy)NSString<Optional> * discount_type;

@property (nonatomic, copy)NSString<Optional> * discount_type_data;

@property (nonatomic, copy)NSString<Optional> * extra_price;

@property (nonatomic, copy)NSString<Optional> * goods_id;

@property (nonatomic, copy)NSString<Optional> * image;

@property (nonatomic, copy)NSString<Optional> * num;

@property (nonatomic, copy)NSString<Optional> * number;

@property (nonatomic, copy)NSString<Optional> * old_price;

@property (nonatomic, copy)NSString<Optional> * old_price_all;

@property (nonatomic, copy)NSString<Optional> * packing_charge;

@property (nonatomic, copy)NSString<Optional> * packname;

@property (nonatomic, copy)NSString<Optional> * price;

@property (nonatomic, copy)NSString<Optional> * sort_id;

@property (nonatomic, copy)NSString<Optional> * spec_id;

@property (nonatomic, copy)NSString<Optional> * str; //规格属性 草

@property (nonatomic, copy)NSString<Optional> * unit;

@property (nonatomic, copy)NSString<Optional> * name;

@end

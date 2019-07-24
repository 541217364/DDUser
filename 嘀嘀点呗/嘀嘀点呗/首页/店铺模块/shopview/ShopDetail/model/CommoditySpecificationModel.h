//
//  CommoditySpecificationModel.h
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/5/4.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import "JSONModel.h"



@interface SpecModel : JSONModel

@property (nonatomic, copy)NSString<Optional> * spec_val_id;

@property (nonatomic, copy)NSString<Optional> * spec_val_name;

@end


@protocol  SpecModel

@end


@interface CommoditySpecificationModel : JSONModel

@property (nonatomic, copy)NSString<Optional> * cost_price;

@property (nonatomic, copy)NSString<Optional> * index;

@property (nonatomic, copy)NSString<Optional> * max_num;

@property (nonatomic, copy)NSString<Optional> * number;

@property (nonatomic, copy)NSString<Optional> * old_price;

@property (nonatomic, copy)NSString<Optional> * price;

@property (nonatomic, copy)NSString<Optional> * seckill_price;

@property (nonatomic, copy)NSString<Optional> * stock_num;

@property (nonatomic, copy)NSArray<Optional> * properties;

@property (nonatomic, copy)NSString<Optional> * packing_charge;

@property (nonatomic, assign)NSArray<Optional,SpecModel> * spec;



@end

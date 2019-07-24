//
//  StoreModel.h
//  嘀嘀点呗
//
//  Created by xgy on 2017/12/6.
//  Copyright © 2017年 xgy. All rights reserved.
//

#import "JSONModel.h"


@protocol StoreItem


@end

@interface StoreItem : JSONModel

@property (nonatomic, copy)NSString<Optional> * type;

@property (nonatomic, copy)NSString<Optional> * value;

@end


@interface StoreModel : JSONModel

@property (nonatomic, copy)NSString<Optional> * store_id;

@property (nonatomic, copy)NSString<Optional> * name;

@property (nonatomic, copy)NSString<Optional> * phone;

@property (nonatomic, copy)NSString<Optional> * store_theme;

@property (nonatomic, copy)NSString<Optional> * isverify;

@property (nonatomic, copy)NSString<Optional> * juli_wx;

@property (nonatomic, copy)NSString<Optional> * range;

@property (nonatomic, copy)NSString<Optional> * image;

@property (nonatomic, copy)NSString<Optional> * star;

@property (nonatomic, copy)NSString<Optional> * month_sale_count;

@property (nonatomic, copy)NSString<Optional> * delivery;

@property (nonatomic, copy)NSString<Optional> * adress;

@property (nonatomic, copy)NSString<Optional> * delivery_time;

@property (nonatomic, copy)NSString<Optional> * send_time_type;

@property (nonatomic, copy)NSString<Optional> * delivery_time_type;

@property (nonatomic, copy)NSString<Optional> * delivery_price;

@property (nonatomic, copy)NSString<Optional> * delivery_money;

@property (nonatomic, copy)NSString<Optional> * delivery_type;

@property (nonatomic, copy)NSString<Optional> * delivery_system;

@property (nonatomic, copy)NSString<Optional> * is_close;

@property (nonatomic, copy)NSString<Optional> * time;

@property (nonatomic, copy)NSArray<Optional,StoreItem> * coupon_list;

@property (nonatomic, copy)NSString<Optional> * coupon_count;

@property (nonatomic, copy)NSString<Optional> * permoney;

@property (nonatomic, copy)NSArray<Optional> * tag;

@property (nonatomic, copy)NSString<Optional> * isyes;

@property (nonatomic, copy)NSString<Optional> * is_brand; //品牌

@property (nonatomic, copy)NSString<Optional> * is_new_shop; //新店

@property (nonatomic, copy)NSArray<Optional> *auth_files;

@property (nonatomic, copy)NSString<Optional> * txt_info;

@property (nonatomic, copy)NSString<Optional> * id;

@property (nonatomic, copy)NSString<Optional> * is_collection;

@property (nonatomic, copy)NSString<Optional> * store_notice;

@property (nonatomic, copy)NSString<Optional> *max_num;



@end

//
//  StoreSeachModel.h
//  嘀嘀点呗
//
//  Created by xgy on 2018/5/19.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import "JSONModel.h"

@protocol CouponItem


@end

@protocol GoodItem


@end

@interface CouponItem : JSONModel

@property (nonatomic, strong) NSString<Optional>* tag;

@property (nonatomic, strong) NSString<Optional>* type;

@property (nonatomic, strong) NSString<Optional>* value;

@end

@interface GoodItem : JSONModel

@property (nonatomic, strong) NSString<Optional>* goods_id;

@property (nonatomic, strong) NSString<Optional>* name;

@property (nonatomic, strong) NSString<Optional>* price;

@property (nonatomic, strong) NSString<Optional>* search_name;

@property (nonatomic, strong) NSString<Optional>* sell_count;

@property (nonatomic, strong) NSString<Optional>* sort_id;

@property (nonatomic, strong) NSString<Optional>* store_id;

@property (nonatomic, strong) NSString<Optional>* unit;

@property (nonatomic, strong) NSString<Optional>* g_image;

@property (nonatomic, strong) NSString<Optional>* packing_charge;

@property (nonatomic, strong) NSString<Optional>* goodnum;

@property (nonatomic, strong) NSString<Optional>* is_properties;

@property (nonatomic, strong) NSString<Optional>* spec_value;

@property (nonatomic, strong) NSString<Optional>* sort_discount;

@property (nonatomic, strong) NSString<Optional>* max_num;

@property (nonatomic, strong) NSString<Optional>* stock_num;


@end


@interface StoreSeachModel : JSONModel

@property (nonatomic, strong) NSString<Optional>* store_id;

@property (nonatomic, strong) NSString<Optional>* name;

@property (nonatomic, strong) NSString<Optional>* store_name;

@property (nonatomic, strong) NSString<Optional>* isverify;

@property (nonatomic, strong) NSString<Optional>* juli_wx;

@property (nonatomic, strong) NSString<Optional>* image;

@property (nonatomic, strong) NSString<Optional>* star;

@property (nonatomic, strong) NSString<Optional>* month_sale_count;

@property (nonatomic, strong) NSString<Optional>* delivery;

@property (nonatomic, strong) NSString<Optional>* delivery_time;

@property (nonatomic, strong) NSString<Optional>* send_time_type;

@property (nonatomic, strong) NSString<Optional>* delivery_time_type;

@property (nonatomic, strong) NSString<Optional>* delivery_money;

@property (nonatomic, strong) NSString<Optional>* delivery_system;

@property (nonatomic, strong) NSString<Optional>* delivery_price;

@property (nonatomic, strong) NSString<Optional>* permoney;

@property (nonatomic, strong) NSString<Optional>* is_close;

@property (nonatomic, strong) NSString<Optional>* time;

@property (nonatomic, strong) NSString<Optional>* coupon_count;

@property (nonatomic, strong) NSString<Optional>* g_image;

@property (nonatomic, strong) NSArray<Optional>* tag;

@property (nonatomic, strong) NSArray<Optional,CouponItem>* coupon_list;

@property (nonatomic, strong) NSArray<Optional,GoodItem>* goods_list;

@property (nonatomic, strong) NSString<Optional>* isyes;

@property (nonatomic, strong) NSString<Optional>* ismore;

@property (nonatomic, strong) NSString<Optional>* store_mj;

@property (nonatomic, strong) NSString<Optional>* range;

@property (nonatomic, strong) NSString<Optional>*is_brand;

@end

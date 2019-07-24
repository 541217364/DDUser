//
//  StoreInfo.h
//  嘀嘀点呗
//
//  Created by xgy on 2017/12/6.
//  Copyright © 2017年 xgy. All rights reserved.
//

#import "JSONModel.h"
#import "StoreModel.h"

@protocol StoreShopItem


@end

@protocol ProductItem


@end

@protocol StoreProductItem


@end

@interface StoreShopItem : JSONModel

@property (nonatomic, copy)NSString<Optional> * id;

@property (nonatomic, copy)NSString<Optional> * phone;

@property (nonatomic, copy)NSString<Optional> * lng;

@property (nonatomic, copy)NSString<Optional> * lat;

@property (nonatomic, copy)NSString<Optional> * isverify;

@property (nonatomic, copy)NSString<Optional> * store_theme;

@property (nonatomic, copy)NSString<Optional> * adress;

@property (nonatomic, copy)NSString<Optional> * is_close;

@property (nonatomic, copy)NSString<Optional> * time;

@property (nonatomic, copy)NSString<Optional> * name;

@property (nonatomic, copy)NSString<Optional> * store_notice;

@property (nonatomic, copy)NSString<Optional> * txt_info;

@property (nonatomic, copy)NSString<Optional> * image;

@property (nonatomic, copy)NSArray<Optional> * images;

@property (nonatomic, copy)NSArray<Optional> * auth_files;

@property (nonatomic, copy)NSString<Optional> * star;

@property (nonatomic, copy)NSString<Optional> * month_sale_count;

@property (nonatomic, copy)NSString<Optional> * delivery;

@property (nonatomic, copy)NSString<Optional> * delivery_time;

@property (nonatomic, copy)NSString<Optional> * send_time_type;

@property (nonatomic, copy)NSString<Optional> * delivery_time_type;

@property (nonatomic, copy)NSString<Optional> * delivery_price;

@property (nonatomic, copy)NSString<Optional> * delivery_money;

@property (nonatomic, copy)NSString<Optional> * delivery_system;

@property (nonatomic, copy)NSString<Optional> * pick;

@property (nonatomic, copy)NSString<Optional> * pack_alias;

@property (nonatomic, copy)NSString<Optional> * freight_alias;

@property (nonatomic, copy)NSArray<Optional,StoreItem> * coupon_list;

@end

@interface ProductItem : JSONModel

@property (nonatomic, copy)NSString<Optional> * product_id;

@property (nonatomic, copy)NSString<Optional> * product_name;

@property (nonatomic, copy)NSString<Optional> * product_price;

@property (nonatomic, copy)NSString<Optional> * o_price;

@property (nonatomic, copy)NSString<Optional> * number;

@property (nonatomic, copy)NSString<Optional> * packing_charge;

@property (nonatomic, copy)NSString<Optional> * unit;

@property (nonatomic, copy)NSString<Optional> * product_image;

@property (nonatomic, copy)NSString<Optional> * product_sale;

@property (nonatomic, copy)NSString<Optional> * product_reply;

@property (nonatomic, copy)NSString<Optional> * has_format;

@property (nonatomic, copy)NSString<Optional> * is_seckill_price;

@property (nonatomic, copy)NSString<Optional> * stock;

@property (nonatomic, copy)NSString<Optional> * sort_discount;

@property (nonatomic, copy)NSString<Optional> * des;

@property (nonatomic, copy)NSString<Optional> * selectCount;

@property (nonatomic, copy)NSString<Optional> * max_num;

@end



@interface StoreProductItem : JSONModel

@property (nonatomic, copy)NSString<Optional> * cat_id;

@property (nonatomic, copy)NSString<Optional> * cat_name;

@property (nonatomic, copy)NSString<Optional> * sort_discount;

@property (nonatomic, copy)NSArray<Optional,ProductItem> * product_list;

@end




@interface StoreSearchModel: JSONModel

@property (nonatomic, copy)NSString<Optional> * name;

@property (nonatomic, copy)NSString<Optional> * search_name;

@property (nonatomic, copy)NSString<Optional> * image;

@property (nonatomic, copy)NSString<Optional> * sell_count;

@property (nonatomic, copy)NSString<Optional> * des;

@property (nonatomic, copy)NSString<Optional> * has_format;

@end



@interface StoreInfo : JSONModel

@property (nonatomic, copy)NSDictionary<Optional> * store;

@property (nonatomic, copy)NSArray<Optional,StoreProductItem> * product_list;


@end






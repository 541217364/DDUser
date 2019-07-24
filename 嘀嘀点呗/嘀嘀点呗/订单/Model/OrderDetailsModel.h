//
//  OrderDetailsModel.h
//  嘀嘀点呗
//
//  Created by xgy on 2018/5/9.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import "JSONModel.h"
#import "OrderListModel.h"

@protocol StoreDetailsGoodsItem


@end

@protocol StoreDetailsdisCount


@end

@protocol OrderStoreItem


@end


@interface OrderStoreItem : JSONModel

@property (nonatomic, copy)NSString<Optional> * store_id;

@property (nonatomic, copy)NSString<Optional> * store_image;

@property (nonatomic, copy)NSString<Optional> * store_lat;

@property (nonatomic, copy)NSString<Optional> * store_lng;

@property (nonatomic, copy)NSString<Optional> * store_name;

@property (nonatomic, copy)NSArray<Optional> * store_phone;

@end


@interface StoreDetailsGoodsItem : JSONModel

@property (nonatomic, copy)NSString<Optional> * name;

@property (nonatomic, copy)NSString<Optional> * discount_type;

@property (nonatomic, copy)NSString<Optional> * price;

@property (nonatomic, copy)NSString<Optional> * discount_price;

@property (nonatomic, copy)NSString<Optional> * spec;

@property (nonatomic, copy)NSString<Optional> * num;

@property (nonatomic, copy)NSString<Optional> * total;

@property (nonatomic, copy)NSString<Optional> * discount_total;

@property (nonatomic, copy)NSString<Optional> * product_image;

@end


@interface StoreDetailsdisCount : JSONModel

@property (nonatomic, copy)NSString<Optional> * desc;

@property (nonatomic, copy)NSString<Optional> * discount_type;

@property (nonatomic, copy)NSString<Optional> * minus;


@end

@interface OrderDetailsModel : JSONModel

@property (nonatomic, copy)NSString<Optional> * orderid;

@property (nonatomic, copy)NSString<Optional> * order_id;

@property (nonatomic, copy)NSString<Optional> * real_orderid;

@property (nonatomic, copy)NSString<Optional> * username;

@property (nonatomic, copy)NSString<Optional> * userphone;

@property (nonatomic, copy)NSString<Optional> * create_time;

@property (nonatomic, copy)NSString<Optional> * pay_time;

@property (nonatomic, copy)NSString<Optional> * expect_use_time;

@property (nonatomic, copy)NSString<Optional> * is_pick_in_store;

@property (nonatomic, copy)NSString<Optional> * address;

@property (nonatomic, copy)NSString<Optional> * deliver_str;

@property (nonatomic, copy)NSString<Optional> * deliver_status_str;

@property (nonatomic, copy)NSString<Optional> * card_price;

@property (nonatomic, copy)NSString<Optional> * coupon_price;

@property (nonatomic, copy)NSString<Optional> * lat; //用户 经度

@property (nonatomic, copy)NSString<Optional> * lng; //用户 纬度

@property (nonatomic, copy)NSString<Optional> * goods_price;

@property (nonatomic, copy)NSString<Optional> * freight_charge;

@property (nonatomic, copy)NSString<Optional> * packing_charge;

@property (nonatomic, copy)NSString<Optional> * total_price;

@property (nonatomic, copy)NSString<Optional> * merchant_reduce;

@property (nonatomic, copy)NSString<Optional> * balance_reduce;

@property (nonatomic, copy)NSString<Optional> * price;

@property (nonatomic, copy)NSString<Optional> * distance;

@property (nonatomic, copy)NSString<Optional> * discount_price;

@property (nonatomic, copy)NSString<Optional> * minus_price;

@property (nonatomic, copy)NSString<Optional> * go_pay_price;

@property (nonatomic, copy)NSString<Optional> * note;

@property (nonatomic, copy)NSDictionary<Optional> * deliver_info;

@property (nonatomic, copy)NSArray<Optional,OrderStateItem> * deliver_log_list;

@property (nonatomic, copy)OrderStoreItem<Optional> * store;




@end

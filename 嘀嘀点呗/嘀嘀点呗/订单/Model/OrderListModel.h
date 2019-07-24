//
//  OrderListModel.h
//  嘀嘀点呗
//
//  Created by xgy on 2018/5/8.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import "JSONModel.h"


@protocol OrderListItem


@end

@interface OrderListItem : JSONModel

@property (nonatomic, copy)NSString<Optional> * goods_id; 

@property (nonatomic, copy)NSString<Optional> * goods_name; //商品名

@property (nonatomic, copy)NSString<Optional> * goods_num; //购买数量

@property (nonatomic, copy)NSString<Optional> * good_comment;



@end

@protocol OrderStateItem


@end

@interface OrderStateItem : JSONModel

@property (nonatomic, copy)NSString<Optional> * dateline; //商品名

@property (nonatomic, copy)NSString<Optional> * from_type; //购买数量

@property (nonatomic, copy)NSString<Optional> * id;

@property (nonatomic, copy)NSString<Optional> * name;

@property (nonatomic, copy)NSString<Optional> * note;

@property (nonatomic, copy)NSString<Optional> * order_id;

@property (nonatomic, copy)NSString<Optional> * phone;

@property (nonatomic, copy)NSString<Optional> * status;

@property (nonatomic, copy)NSString<Optional> *status_des;

@end


@interface OrderListModel : JSONModel

@property (nonatomic, copy)NSString<Optional> * real_orderid; //订单号

@property (nonatomic, copy)NSString<Optional> * create_time;  //创建时间

@property (nonatomic, copy)NSString<Optional> * name;  //店铺名称

@property (nonatomic, copy)NSString<Optional> * num;   //购买商品总数

@property (nonatomic, copy)NSString<Optional> * image;   

@property (nonatomic, copy)NSString<Optional> * store_id;

@property (nonatomic, copy)NSString<Optional> * order_id; //订单id

@property (nonatomic, copy)NSString<Optional> * price;  //商品总价

@property (nonatomic, copy)NSString<Optional> * statu; //订单状态（0：未接单或者未支付，1：商家确认，2：已完成，3：已评论，:4：退款，5：取消）

@property (nonatomic, copy)NSString<Optional> * paid;  //支付状态（0：未支付，1：已支付）

@property (nonatomic, copy)NSArray<Optional,OrderListItem> * goods_list;  //商品

@property (nonatomic, copy)NSArray<Optional,OrderStateItem> * status;

@property (nonatomic, copy)NSDictionary<Optional> * deliver_place; //骑士经纬度

@property (nonatomic, copy)NSArray<Optional> * phone;


@property (nonatomic, copy)NSString<Optional> *deliver_type;  //0 系统单  1 自配送单





@end

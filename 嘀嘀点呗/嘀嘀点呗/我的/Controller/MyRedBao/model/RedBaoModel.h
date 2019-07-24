//
//  RedBaoModel.h
//  嘀嘀点呗
//
//  Created by 周启磊 on 2018/5/24.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import "JSONModel.h"

@interface RedBaoModel : JSONModel

@property (nonatomic, copy)NSString<Optional> * name;

@property (nonatomic, copy)NSString<Optional> * cate_name;

@property (nonatomic, copy)NSString<Optional> * order_money;

@property (nonatomic, copy)NSString<Optional> * discount;

@property (nonatomic, copy)NSString<Optional> * end_time;

@property (nonatomic, copy)NSString<Optional> * img;

@property (nonatomic, copy)NSString<Optional> * phone;

@end


@interface ShopDis : JSONModel

@property (nonatomic, copy)NSString<Optional> * name;

@property (nonatomic, copy)NSString<Optional> * order_money;

@property (nonatomic, copy)NSString<Optional> * discount;

@property (nonatomic, copy)NSString<Optional> * end_time;

@property (nonatomic, copy)NSString<Optional> * img;

@property (nonatomic, copy)NSString<Optional> * store_name;


@end


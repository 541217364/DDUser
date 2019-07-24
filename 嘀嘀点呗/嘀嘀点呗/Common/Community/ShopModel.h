//
//  ShopModel.h
//  嘀嘀点呗
//
//  Created by xgy on 2018/4/16.
//  Copyright © 2018年 xgy. All rights reserved.
//

#import "JSONModel.h"

@interface ShopModel : JSONModel

@property (nonatomic, copy)NSString<Optional> * store_id;

@property (nonatomic, copy)NSString<Optional> * goodname;

@property (nonatomic, copy)NSString<Optional> * goodId;

@property (nonatomic, copy)NSString<Optional> * goodprice;

@property (nonatomic, copy)NSString<Optional> * goodnum;

@property (nonatomic, copy)NSString<Optional> * attributename;

@property (nonatomic, copy)NSString<Optional> * goodimg;

@property (nonatomic, copy)NSString<Optional> * pickprice;


@end
